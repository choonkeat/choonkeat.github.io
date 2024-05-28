---
layout: post
title: "Stop handling HTTP requests with HTTP response"
published: true
---

In most platforms, our functions that deal with http requests have the same signature

```go
// go
func(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(200)
    w.Write([]byte("Hello"))
}
```

```ts
// typescript
function handler(req: http.IncomingMessage, res: http.ServerResponse) {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end("Hello");
}
```

It is the same for Ruby, Python, etc. It's the same even if [your platform makes them implicit](https://guides.rubyonrails.org/getting_started.html), or [puts them both into a single argument and call it `ctx` instead.](https://koajs.com)

Yes, platforms _have_ to provide them because they are the primitives! But we don't _have_ to write our http handlers in a primitive manner.

#### What's the problem?

When we work with the `HttpResponse` directly, our code is imperative, we mutate state, and can easily reach inconsistent outcome: someone implements X, someone fixes Y, and before you know it, weird combinations manifest:

```js
app.get('/hello', (req: Request, res: Response) => {
    try {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.write(headerHTML);
        res.write(`<h1>Hello, ${userName(req)}!</h1>`);
        res.write(footerHTML);
        res.end();
    } catch (err) {
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Internal Server Error', message: err.message }));
    }
});
```

i.e. if `userName` encounters an error, nasty:

```
HTTP/1.1 200 OK
Content-Type: text/html

<html>
    <head>...</head>
    <body>{ "error": "Internal Server Error" }
```

Sure we can fix _this_ bug, but it's just whack-a-mole: there is infinite combinations of things that can happen. e.g. setting the same cookie multiple times in a request is oddly common.

#### What's the solution?

Though http response itself entertains an infinite combination of things, our web application (no matter how big and complex) will only have finite variations of responses: redirect, set cookie and redirect, render page with layout, render page with different layout, error page, json payload, json error, ... the list goes on, but it will end.

```ts
type AppResponse =
    | { type: 'redirect'; url: string }
    | { type: 'redirectWithCookie'; url: string; cookie: string; cookieValue: string }
    | { type: 'renderPage'; content: string }
    | { type: 'renderPageWithDifferentLayout'; content: string }
    | { type: 'errorPage'; message: string; statusCode: number }
    | { type: 'jsonPayload'; data: any }
    | { type: 'jsonError'; err: any; statusCode: number };
    // Exercise left for the reader: sharpen away those `string`, `number`, and `any`
```

To paraphrase a popular adage: _if you can't list them, you can't manage them._

```ts
function handleAppResponse(handler: (req: Request) => AppResponse) {
    return (req: Request, res: Response) => {
        const response = handler(req);
        switch (response.type) {
            case 'redirect':
                res.writeHead(302, { 'Location': response.url });
                res.end();
                break;
            case 'redirectWithCookie':
                res.writeHead(302, { 'Location': response.url, 'Set-Cookie': `${response.cookie}=${response.cookieValue}` });
                res.end();
                break;
            case 'renderPage':
                res.writeHead(200, { 'Content-Type': 'text/html' });
                res.end(`<html><body>${mainHeader}${response.content}${mainFooter}</body></html>`);
                break;
            case 'renderPageWithDifferentLayout':
                // ...
```

Yes, we have to handle all variants in a helper function. But it's really no big deal to do it once for the entire web app.

```ts
app.get('/hello', handleAppResponse(handleHello));
app.get('/goodbye', handleAppResponse(handleGoodbye));
// ...
```

But we end up writing simpler functions!

```ts
function handleHello(req: Request): AppResponse {
    try {
        const content = `<h1>Hello, ${userName(req)}!</h1>`;
        return { type: 'renderPage', content };
    } catch (err) {
        return { type: 'jsonError', err, statusCode: 500 };
    }
}
```

and in Go [with sum types](https://github.com/choonkeat/sumtype-go)

```go
func handleHello(r *http.Request) AppResponse {
    uname, err := userName(r)
    if err != nil {
        return JsonError(err, http.StatusInternalServerError)
    }
    return RenderPage(
        dom.H1(
            dom.Attrs("id", "greeting"), // choonkeat/dom-go
            dom.InnerText("Hello, "),
            dom.InnerText(uname),
        ),
    )
}
```

We've constrained our http handlers to return `AppResponse`. We can't mutate `http.Response` directly. How our web app respond is all managed in a single place. There's no whack-a-mole problem anymore.

_Food for thought: if we take 1 more step to replace `http.Request` with our own `AppRequest`, then our handlers are just functions `handleHello(AppRequest): AppResponse` -- we don't even need to fiddle with http to unit test our http handlers?_
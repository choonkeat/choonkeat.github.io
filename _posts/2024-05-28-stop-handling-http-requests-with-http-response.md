---
layout: post
title: "Stop handling HTTP requests with HTTP response"
published: true
---

In most platforms, our functions that deal with http requests have the same signature

```go
// go
func(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "text/plain")
    w.WriteHeader(http.StatusOK)
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

It is the same for Ruby, Python, etc. It's the same even if [your platform makes them implicit](https://guides.rubyonrails.org/getting_started.html), or [puts them _both_ into a _single_ argument named `ctx` instead.](https://koajs.com)

Yes, platforms _have_ to provide them because they are the primitives. But we don't _have_ to write our http handlers in a primitive manner!

### What's the problem?

When we work with the `HttpResponse` directly, our code is imperative, irreversible, we mutate the response as we go, and can easily become incoherent: someone implements X, someone fixes Y, and before you know it, the code path contain weird combinations:

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

Looks fine at a glance? But if `userName` encounters an error, it's nasty:

```
HTTP/1.1 200 OK
Content-Type: text/html

<html>
    <head>...</head>
    <body>{ "error": "Internal Server Error" }
```

Sure we can fix _this_ bug, but the situation is just whack-a-mole: there is infinite combinations of things that can happen. e.g. setting the same cookie multiple times in a request is oddly common.

### What's the solution?

Though http response itself entertains an infinite combination of things, our web application (no matter how big and complex) will only have finite variations of responses: redirect, set cookie _and redirect_, render page with layout, render page with _different layout_, error page, json payload, json error, ... the list goes on, but it will end.

```ts
type AppResponse =
    | { type: 'redirect'; url: string }
    | { type: 'renderPage'; content: string }
    // ...
```

To paraphrase a popular adage: _if you can't list them, you can't manage them._

```ts
function handleResponse(res: Response, response: AppResponse) {
    switch (response.type) {
        case 'redirect':
            res.writeHead(302, { 'Location': response.url });
            res.end();
            break;
        case 'renderPage':
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(`<html><body>${mainHeader}${response.content}${mainFooter}</body></html>`);
            break;
        // ...
```

Yes, we have to handle all variants in our helper function. But it's not _more_ work; we have to do them anyways. The difference is, they are all managed in the same place now.

```ts
function handleAppResponse(handler: (req: Request) => AppResponse): (req: Request, res: Response) => void {
    return (req: Request, res: Response) => {
        const response = handler(req);
        handleResponse(res, response);
    };
}

app.get('/hello', handleAppResponse(handleHello));
app.get('/goodbye', handleAppResponse(handleGoodbye));
// ...
```

What we get after all this, is that our "http handlers" have _all_ become simpler functions! We don't have to fiddle with mutating `http.Response`; we can't because we don't have access to it! Just return the appropriate response variant!

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

and in Go [with sum types](https://github.com/choonkeat/sumtype-go) <sup>[[1]](#footnote1)</sup>

```go
func handleHello(r *http.Request) AppResponse {
    uname, err := userName(r)
    if err != nil {
        return JsonError(err, http.StatusInternalServerError)
    }
    return RenderPage(
        dom.H1( // github.com/choonkeat/dom-go
            dom.Attrs("id", "greeting"),
            dom.InnerText("Hello, "),
            dom.InnerText(uname),
        ),
    )
}
```

We've constrained our http handlers to return `AppResponse`. We can't mutate `http.Response` directly. How our web app respond is all managed in a single place. There's no whack-a-mole problem anymore.

_Food for thought: if we take 1 more step to replace `http.Request` with our own `AppRequest`, then our handlers are just functions `handleHello(AppRequest): AppResponse` -- we don't even need to fiddle with http to unit test our http handlers?_

<sub><a name="footnote1">[1]</a>
You can also embrace returning-a-value as solution in Go without defining your own sum type [using this library](https://github.com/alvinchoong/go-httphandler)
</sub><br/>

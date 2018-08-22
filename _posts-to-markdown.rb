require 'htmlentities'
require 'yaml'
require 'reverse_markdown'
require 'nokogiri'

Dir['_posts/*.html'].each do |line|
    frontmatter_s, html_s = IO.read(line).split("\n---")
    puts "#{line}"
    frontmatter = YAML.load frontmatter_s
    frontmatter["title"] = HTMLEntities.new.decode(frontmatter["title"])
    output = [
        frontmatter.to_yaml,
        html_s.strip + "\n"
    ].join("---\n")
    open(line, "w") {|f| f.write(output); f.flush }

    doc = Nokogiri::HTML(html_s)
    doc.css("*").each do |x|
        case x.name.downcase
        when 'embed', 'object', 'param'
            # keep
        else
            x.attributes.each do |k,v|
                case k
                when "href", "src"
                    # keep
                else
                    x.delete k
                end
            end
        end
    end

    content_markdown = ReverseMarkdown.convert(doc.css("body").inner_html.strip).gsub('&nbsp;', '')
    if content_markdown.strip == ""
        puts ""
        puts "html:"
        puts doc.css("body").inner_html.inspect
        puts ""
        puts html_s.inspect
        puts ""
        raise "Blank?"
    end
    output = [
        frontmatter.to_yaml,
        content_markdown
    ].join("---\n")
    outfile = line.gsub(/\.html$/, '.md').gsub('_posts', '_posts-md')
    puts "\t\t-> #{outfile}"
    open(outfile, "w") {|f| f.write(output); f.flush }
end

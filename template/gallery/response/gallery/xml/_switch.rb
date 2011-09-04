# set HTTP header
set_header "Content-Type", "application/xml"

# you can access HTTP body as XML document by 'xml_body'.
# xml_body is Nokogiri::XML::Document object.
# See Nokogiri website for more info.
# http://nokogiri.org/
case xml_body.xpath("/root/query").first.text
when "foo"
  # curl -XPOST http://localhost:9292/gallery/xml -d"<root><query>foo</query></root>"
  render "foo.xml"
when "bar"
  # curl -XPOST http://localhost:9292/gallery/xml -d"<root><query>bar</query></root>"
  render "bar.xml"
end

# if nothing to match, use 404 HTTP Status Code and render default.xml.
status_code 404

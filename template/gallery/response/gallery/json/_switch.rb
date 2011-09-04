# set HTTP header
set_header "Content-Type", "application/json"

# you can access POST body as json by 'json_body'
case json_body.query
when "foo"
  # curl -XPOST http://localhost:9292/gallery/json -d"{\"query\":\"foo\"}"
  render "foo.json"
when "bar"
  # curl -XPOST http://localhost:9292/gallery/json -d"{\"query\":\"bar\"}"
  render "bar.json"
end

# if nothing to match, use 404 HTTP Status Code and render default.json.
status_code 404
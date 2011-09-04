# you can access URL parameters by 'params'
case params[:key]
when "foo"
  # curl http://localhost:9292/gallery/params?key=foo
  render "foo.txt"
when "bar"
  # You can also use POST or PUT. See 'rest' more about hadling HTTP methods.
  # curl -XPOST http://localhost:9292/gallery/params -d"key=bar"
  render "bar.txt"
end

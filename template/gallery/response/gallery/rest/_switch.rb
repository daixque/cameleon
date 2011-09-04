# 'on' method handles HTTP Methods.
on(:get) {
  # curl -XGET "http://localhost:9292/gallery/rest"
  render "get.txt"
}
on(:put, :post) {
  # curl -XPUT "http://localhost:9292/gallery/rest" -d=""
  render "put_or_post.txt"
}

# or simply 'get', 'put', 'post' and 'delete' methods are available for same purpose.
# this is same as on(:delete) {}
delete {
  # curl -XDELETE "http://localhost:9292/gallery/rest"
  render "delete.txt"
}
# set HTTP status code (default: 200)
status_code 200

# set HTTP Header
set_header "content-type", "text/plain"

# select response file
render "default"
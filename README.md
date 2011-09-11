Cameleon
=======================================

Cameleon (not Chameleon!) is HTTP mock server framework based on Rack. You can easily create HTTP server for mockup or stub of external system for your application.

All you have to do to create a new interface is simply make directory and put text file into the directory.

Features:

 - Simple API for "_switch.rb" (for selecting response file)
 - Communicate in JSON, XML or any format over HTTP
 - Easy to create RESTful API


## Installation
You can install Cameleon using RubyGems as below:

    $ gem install cameleon

  
## Getting started
First, create a new Cameleon project.

    $ cameleon new your_project_name.

Then move the directory now you created, and launch cameleon server.

    $ cd your_project_name
    $ cameleon server

OK, your server is now running. Test your server using curl.

    $ curl http://localhost:9292
    Hey, I am cameleon!
    Edit response folder to change response whatever you want.
    see README.md more detail.


## Usage
### creating HTTP interface
Think about creating HTTP interface such like below:

 - URL: /path/to/interface
 - response: "ok"

Then all you have to do are below:

    $ mkdir -p response/path/to/interface
    $ cd response/path/to/interface
    $ echo "ok" > default.txt

Test the interface:

    $ curl http://localhost:9292/path/to/interface
    ok

### generate command
Or simply, you can create a interface using "cameleon generate" command.
If you want to create a new interface "/path/to/foo", type:

    $ cameleon generate path/to/foo

and test it.

    $ curl http://localhost:9292/path/to/foo
    edit me: response/path/to/foo/default

So edit the file as you need.

### _switch.rb
If you want to change the response by HTTP request, you shold create "_switch.rb" in your response directory.

Below shows a sample of "_switch.rb".

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
    
    # if else, render "default" (any extention acceptable) file.


## Gallery
You can get various samples using "cameleon gallery" command.
    $ cd YOUR_CAMELEON_HOME
    $ cameleon gallery

Check out response/gallery directory and "_switch.rb" to know usage of APIs.


## License
Cameleon is released under the MIT license.


## Copyright
Copyright (c) 2011 [daisuke sugimori][1] ([@daixque][2]).

[1]: http://opentechnica.blogspot.com/
[2]: http://twitter.com/daixque

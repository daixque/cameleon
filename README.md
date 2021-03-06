Cameleon
=======================================

Cameleon (not Chameleon!) is HTTP mock/stub server framework based on Rack. 
You can easily create HTTP server behaves as external system for your application.

All you have to do to create a new HTTP interface is simply make directory and put response file into the directory.

Features:

 - Easy to create new HTTP interfaces (only to create directory and put response file into it)
 - Simple API for "_switch.rb" (for selecting response file)
 - Communicate in JSON, XML or any other format over HTTP
 - Ready for RESTful API


## Installation
You can install Cameleon using RubyGems as below:

    $ gem install cameleon

  
## Getting started
Create a new Cameleon project using 'cameleon new' command.

    $ cameleon new your_project_name

Move to the directory and start cameleon server.

    $ cd your_project_name
    $ cameleon server

OK, your server is now running. Test your server using curl.

    $ curl http://localhost:9292
    Hey, I am cameleon!
    Edit response folder to change response whatever you want.
    see README.md more detail.


## Usage
### creating HTTP interface
Create HTTP interface such as:

 - URL: GET /path/to/interface
 - response: "ok"

Follow these lines:

    $ mkdir -p response/path/to/interface
    $ cd response/path/to/interface
    $ echo "ok" > default.txt

Test the interface:

    $ curl http://localhost:9292/path/to/interface
    ok

### generate command
You can also create a interface using "cameleon generate" command.
To create a new interface "GET /path/to/foo", type:

    $ cameleon generate path/to/foo

and test it.

    $ curl http://localhost:9292/path/to/foo
    edit me: response/path/to/foo/default

Edit the file as you need.

### _switch.rb
Create "_switch.rb" in your response directory to change the response by HTTP request.
"_switch.rb" is pure Ruby file. You can write any logic you need in Ruby.

_switch.rb

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

Call *render* method to select response file.
When *render* called, evaluation of "_switch.rb" will be terminated and following code won't be interpreted.

### RESTful URI
Cameleon supports RESTful URI (including path variable) such as:

    http://localhost:9292/resource/${category_name}/${id}

To create such URI, create directory as:

    response/resource/$category_name/$id

Directory that name start with '$' is placeholder of the URI.
If directory name is '$category_name/$id' and URI 'fiction/12',
'fiction' and '12' are mapped into params['category_name'] and params['id'].
Then in your _switch.rb or response(erb) file,
you can use params['category_name'] and params['id'] to access the path variable.

### Validation
Cameleon can validate HTTP request body. Currently JSON format is supported. If you want to validate your request to Cameleon,  add 'validation' attribute and 'type' sub-attribute as 'json' into your 'cameleon.yml' config file.

    port: 9292
    validation:
      type: json

then put 'request.schema.json' into response directory. If your interface allows json request body like:

    {"a": 1}

You should create 'request.schema.json' like:

    {
      "type" : "object",
      "properties" : {
        "a" : {
          "type" : "integer",
          "required" : true
        }
      }
    }

Cameleon uses json-schema gem as validation engine, and it's based on [JSON Schema Draft 3](http://tools.ietf.org/html/draft-zyp-json-schema-03). See [json-schema](https://github.com/hoxworth/json-schema) for more detail.

Notice:

Cameleon validates request body only in POST or PUT http method.

### initializer.rb : Setup for _switch.rb

To use some libraries or your own modules on your _switch.rb, cameleon load initializer.rb on boot-time.
You can write some code inside Cameleon::setup scope.

    Cameleon::setup do |config|
      require 'some_library'
      config.foo = 'FOO'
    end

*config* object can be referred as *Cameleon.config* in _switch.rb.

    Cameleon.config.foo #=> 'FOO'

## Gallery
Create various samples using "cameleon gallery" command.

    $ cd YOUR_CAMELEON_HOME
    $ cameleon gallery

Check out response/gallery directory and "_switch.rb" to know some usage of APIs.


## License
Cameleon is released under the MIT license.


## Copyright
Copyright (c) 2011 - 2015 [daisuke sugimori][1] ([@daixque][2]).

[1]: http://opentechnica.blogspot.com/
[2]: http://twitter.com/daixque

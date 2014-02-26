Cameleon::setup do |config|
  # Write your own initialization code
  # such as loading some library for _switch.rb

  # Argument 'config' is Hashie::Mash object that is set values from cameleon.yml.
  # You can set your own values into conifg,
  # and read the value in _switch.rb through Cameleon.config.
  # example: 
  #     config.foo = 'FOO'
  # in _switch.rb
  #     Cameleon.config.foo #=> 'FOO'
end

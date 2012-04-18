require 'ostruct'

require 'rspec'
require 'rspec/autorun'

def needs(path)
  current_directory = File.dirname(__FILE__)
  full_path = File.expand_path(current_directory + '/../' + path)
  unless $:.include?(full_path)
    $: << full_path
  end
end

def stub_module(full_name)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      puts name
      context.const_get(name)
    rescue NameError
      puts name
      context.const_set(name, Module.new)
    end
  end
end

def stub_class(full_name)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue NameError
      context.const_set(name, Class.new)
    end
  end
end

def test_helper(*names)
  names.each do |name|
    name = name.to_s
    name = $1 if name =~ /^(.*?)_test_helper$/i
    name = name.singularize
    first_time = true
    begin
      constant = (name.camelize + 'TestHelper').constantize
      self.class_eval { include constant }
    rescue NameError
      filename = File.expand_path(SPEC_ROOT + '/../test/helpers/' + name + '_test_helper.rb')
      require filename if first_time
      first_time = false
      retry
    end
  end
end
require "radiant/engine"

module Radiant
  def self.table_prefix
    @table_prefix
  end
  
  def self.table_prefix=(val)
    @table_prefix = val
  end
  
  def self.prefixed_table_name(name)
    "#{@table_prefix}#{name}"
  end
  
  def self.table_name(klass)
    name = klass.name
    name.gsub!(/radiant::/i,'').downcase!
    prefixed_table_name(name.pluralize)
  end
end

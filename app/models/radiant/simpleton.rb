module Radiant::Simpleton

  def instance(&block)
    @instance ||= new
    block.call(@instance) if block_given?
    @instance
  end

  def method_missing(method, *args, &block)
    instance.respond_to?(method) ? instance.send(method, *args, &block) : super
  end

end
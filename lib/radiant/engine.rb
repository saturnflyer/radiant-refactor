module Radiant
  class Engine < ::Rails::Engine
    isolate_namespace Radiant
    engine_name "radiant"
    
    config.app_generators.test_framework :rspec
  end
end

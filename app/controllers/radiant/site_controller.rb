module Radiant
  class SiteController < ApplicationController
    def show
      rendering = Rendering.new(request.uri, request.headers)
      render rendering.call
    end
  end
end
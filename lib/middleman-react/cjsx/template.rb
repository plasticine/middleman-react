# encoding: UTF-8

require 'tilt'
require 'coffee-react'

module Middleman
  module React
    module CJSX
      # Tilt Tempalte for handling CJSX files
      class Template < Tilt::Template
        self.default_mime_type = 'application/javascript'

        cattr_accessor :harmony
        cattr_accessor :strip_types

        @harmony = false
        @strip_types = false

        def prepare
          if self.class.harmony || options.key?(:harmony)
            options[:harmony] = self.class.harmony
          end
          if self.class.strip_types || options.key?(:stripTypes)
            options[:stripTypes] = self.class.strip_types
          end
        end

        def evaluate(_scope, _locals, &_block)
          @coffee ||= ::CoffeeReact.transform(data, options)
          @output ||= ::CoffeeScript.compile @coffee
        end
      end
    end
  end
end

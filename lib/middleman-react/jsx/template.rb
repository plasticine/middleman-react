# encoding: UTF-8

require 'tilt'

module Middleman
  module React
    # Tilt Tempalte for handling JSX files
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
        @output ||= JSX.transform(data, options)
      end
    end
  end
end

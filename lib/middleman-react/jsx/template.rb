# encoding: UTF-8

require 'tilt'

module Middleman
  module React
    # Tilt Tempalte for handling JSX files
    class Template < Tilt::Template
      self.default_mime_type = 'application/javascript'

      def prepare; end

      def evaluate(scope, locals, &block)
        @output ||= JSX.transform(data)
      end
    end
  end
end

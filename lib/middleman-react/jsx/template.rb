require 'tilt'

module Middleman
  module React
    class Template < Tilt::Template
      self.default_mime_type = 'application/javascript'

      def prepare; end

      def evaluate(scope, locals, &block)
        @output ||= JSX::transform(data)
      end
    end
  end
end

require 'execjs'
require 'react/source'

module Middleman
  module React
    # Methods for invoking the JSXTransformer via ExecJS
    module JSX
      def self.context
        contents =
          # If execjs uses therubyracer, there is no 'global'. Make sure
          # we have it so JSX script can work properly.
          'var global = global || this;' +
          File.read(::React::Source.bundled_path_for('JSXTransformer.js'))
        @context ||= ExecJS.compile(contents)
      end

      def transform(code)
        context.call('JSXTransformer.transform', code)['code']
      end
      module_function :transform
    end
  end
end

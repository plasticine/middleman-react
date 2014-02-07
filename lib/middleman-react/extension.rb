require 'middleman-core'
require 'middleman-react/jsx'
require 'middleman-react/jsx/template'

# Middleman extension entry point
module Middleman
  module React
    class Extension < Middleman::Extension
      def initialize(app, options_hash = {}, &block)
        ::Tilt.register 'jsx', Middleman::React::Template
        ::Sprockets.register_engine 'jsx', Middleman::React::Template
      end
    end
  end
end

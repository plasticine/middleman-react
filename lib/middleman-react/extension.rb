require 'middleman-core'
require 'middleman-react/jsx'
require 'middleman-react/jsx/template'

module Middleman
  module React
    # Middleman extension entry point
    class Extension < Middleman::Extension
      def initialize(app, options_hash = {}, &block)
        ::Tilt.register 'jsx', Middleman::React::Template
        ::Sprockets.register_engine 'jsx', Middleman::React::Template
      end
    end
  end
end

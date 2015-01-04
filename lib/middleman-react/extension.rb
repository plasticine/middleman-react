# encoding: UTF-8

require 'middleman-core'
require 'middleman-react/jsx'
require 'middleman-react/jsx/template'

module Middleman
  module React
    # Middleman extension entry point
    class Extension < Middleman::Extension
      option :harmony, false, 'The option of harmony'
      option :strip_types, false, 'The option of stripTypes'

      def initialize(app, options_hash = {}, &block)
        super

        Middleman::React::Template.harmony = options[:harmony]
        Middleman::React::Template.strip_types = options[:strip_types]

        ::Tilt.register 'jsx', Middleman::React::Template
        ::Sprockets.register_engine 'jsx', Middleman::React::Template
      end
    end
  end
end

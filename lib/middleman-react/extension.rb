# encoding: UTF-8

require 'middleman-core'
require 'middleman-react/jsx'
require 'middleman-react/jsx/template'
require 'middleman-react/helpers'

module Middleman
  module React
    # Middleman extension entry point
    class Extension < Middleman::Extension
      option :harmony, false, 'The option of harmony'
      option :strip_types, false, 'The option of stripTypes'
      option :components, ['components.js'], 'List of files for precompiling'
      option :replay_console, true, 'Replay console for prerendered components'

      def initialize(app, options_hash = {}, &block)
        super

        Middleman::React::Template.harmony = options[:harmony]
        Middleman::React::Template.strip_types = options[:strip_types]

        Middleman::React::Renderer.components = options[:components]
        Middleman::React::Renderer.replay_console = options[:replay_console]

        ::Tilt.register 'jsx', Middleman::React::Template
        ::Sprockets.register_engine 'jsx', Middleman::React::Template

        app.helpers Middleman::React::Helpers
      end
    end
  end
end

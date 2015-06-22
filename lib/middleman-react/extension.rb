# encoding: UTF-8

require 'middleman-core'
require 'middleman-react/jsx'
require 'middleman-react/jsx/template'
require 'middleman-react/cjsx/template'

module Middleman
  module React
    # Middleman extension entry point
    class Extension < Middleman::Extension
      option :harmony, false, 'The option of harmony'
      option :strip_types, false, 'The option of stripTypes'

      def initialize(app, options_hash = {}, &block)
        super

        Middleman::React::JSX::Template.harmony = options[:harmony]
        Middleman::React::JSX::Template.strip_types = options[:strip_types]
        Middleman::React::CJSX::Template.harmony = options[:harmony]
        Middleman::React::CJSX::Template.strip_types = options[:strip_types]

        ::Tilt.register 'jsx', Middleman::React::JSX::Template
        ::Sprockets.register_engine 'jsx', Middleman::React::JSX::Template

        ::Tilt.register 'cjsx', Middleman::React::CJSX::Template
        ::Sprockets.register_engine 'cjsx', Middleman::React::CJSX::Template
      end

      def after_configuration
        @app.template_extensions cjsx: :js, jsx: :js
      end
    end
  end
end

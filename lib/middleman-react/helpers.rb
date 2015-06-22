require 'middleman-react/renderer'

module Middleman
  module React
    # Helper method to render react components
    module Helpers
      # rubocop:disable Metrics/MethodLength
      def react_component(name, args = {}, options = {}, &block)
        options = { tag: options } if options.is_a?(Symbol)
        content = ''

        if options[:prerender]
          content = Middleman::React::Renderer.render(self, name, args)
        end

        html_options = options.reverse_merge(data: {})
        html_options[:data].tap do |data|
          data[:react_class] = name
          unless args.empty?
            data[:react_props] = Middleman::React::Renderer.react_props(args)
          end
        end

        html_tag = html_options[:tag] || :div

        # remove internally used properties so they aren't rendered to DOM
        html_options.except!(:tag, :prerender)

        content_tag(html_tag, content, html_options, &block)
      end
    end
  end
end

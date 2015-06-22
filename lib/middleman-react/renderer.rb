module Middleman
  # Handles server-side react rendering
  module React
    def self.react_ujs_path
      File.expand_path('../../../javascript/react_ujs.js', __FILE__)
    end

    # The rendering logic
    class Renderer
      # For when we get a JS error
      class PrerenderError < RuntimeError
        def initialize(component_name, props, js_message)
          message = [
            "Encountered error \"#{js_message}\" when prerendering" \
            " #{component_name} with #{props}",
            js_message.backtrace.join("\n")].join("\n")
          super(message)
        end
      end

      cattr_accessor :components
      cattr_accessor :replay_console

      # rubocop:disable Metrics/LineLength, Metrics/MethodLength, ClassVars
      def self.render(app, component, args = {})
        context = ExecJS.compile(combined_js(app))
        begin
          react_props = React::Renderer.react_props(args)
          jscode = <<-JS
            (function () {
              var result = React.renderToString(React.createElement(#{component}, #{react_props}));
              #{@@replay_console ? Console.replay_as_script_js : ''}
              return result;
            })()
          JS
          context.eval(jscode).html_safe
        rescue ExecJS::ProgramError => e
          raise PrerenderError.new(component, react_props, e)
        end
      end
      # rubocop:enable Metrics/LineLength, Metrics/MethodLength

      def self.react_js
        @@react_js ||= File.read(::React::Source.bundled_path_for('react.js'))
      end

      def self.components_js(app)
        @@components.collect do |comp|
          app.sprockets[comp].source
        end.join('\n')
      end

      def self.combined_js(app)
        @@combined_js = <<-JS
          var global = global || this;
          var self = self || this;
          var window = window || this;
          #{Console.polyfill_js}
          #{react_js};
          React = global.React;
          #{components_js(app)};
        JS
      end

      def self.react_props(args = {})
        if args.is_a? String
          args
        else
          args.to_json
        end
      end
    end

    # Overwrite global `console` object with something that can capture
    # messages to return to client later for debugging
    class Console
      # rubocop:disable Metrics/LineLength, Metrics/MethodLength
      def self.polyfill_js
        <<-JS
        var console = { history: [] };
        ['error', 'log', 'info', 'warn'].forEach(function (fn) {
          console[fn] = function () {
            console.history.push({level: fn, arguments: Array.prototype.slice.call(arguments)});
          };
        });
        JS
      end

      def self.replay_as_script_js
        <<-JS
        (function (history) {
          if (history && history.length > 0) {
            result += '\\n<scr'+'ipt>';
            history.forEach(function (msg) {
              result += '\\nconsole.' + msg.level + '.apply(console, ' + JSON.stringify(msg.arguments) + ');';
            });
            result += '\\n</scr'+'ipt>';
          }
        })(console.history);
        JS
      end
      # rubocop:enable Metrics/LineLength, Metrics/MethodLength
    end
  end
end

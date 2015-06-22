set :js_dir, 'assets/javascripts'

activate :react

after_configuration do
  sprockets.append_path File.dirname(::React::Source.bundled_path_for('react.js'))
  sprockets.append_path File.dirname(Middleman::React::react_ujs_path)
end
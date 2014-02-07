# encoding: UTF-8

require 'middleman-core'

::Middleman::Extensions.register(:react) do
  require 'middleman-react/extension'
  ::Middleman::React::Extension
end

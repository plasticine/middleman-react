ENV["TEST"] = "true"

PROJECT_ROOT_PATH = File.join(File.dirname(__FILE__), '../../../')

require "middleman-core"
require "middleman-core/step_definitions"
require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-react')

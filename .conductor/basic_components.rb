require 'conductor/components/command-line-interface'
require 'conductor/components/screen-workspace'
require 'conductor/components/controller'

module Conductor
  module Components
    UserInterface = CLI
    Workspace = ScreenWorkspace
    Controller = LocalSocketsController
  end
end

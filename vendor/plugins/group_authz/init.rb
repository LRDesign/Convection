if defined?(ApplicationController)
  class ApplicationController
    include GroupAuthz::Application
  end
end

if defined?(ApplicationController)
  class ApplicationController
    include GroupAuthz::Application
  end
end
ActionView::Base.send :include, GroupAuthz::Helper
           
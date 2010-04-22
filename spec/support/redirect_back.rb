module Spec
  module Rails
    module Matchers
      def redirect_back
        RedirectTo.new(request, "/previous/page")
      end
    end
  end
end
           
Spec::Runner.configure do |config|    
  config.prepend_before(:each, :type => :controller) do
    request.env["HTTP_REFERER"] = "/previous/page"
  end
end
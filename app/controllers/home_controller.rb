class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to documents_path
    else
      redirect_to login_path
    end
  end

end

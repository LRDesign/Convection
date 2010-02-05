class UploadsController < ApplicationController    
  before_filter :require_user

  def index
    @documents = Document.find_all_by_user_id(current_user)
  end

end

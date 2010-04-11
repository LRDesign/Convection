class Admin::LogsController < Admin::AdminController
  def index
    @log_entries = LogEntry.paginate(:per_page => 100, 
                          :page => params[:page], 
                          :order => "created_at DESC")
  end

end

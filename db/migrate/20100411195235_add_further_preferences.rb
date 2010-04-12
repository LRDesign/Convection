class AddFurtherPreferences < ActiveRecord::Migration
  def self.up
    add_column(:preferences, :download_notifications, :boolean, :default => true)
    add_column(:preferences, :show_progress_bar,      :boolean, :default => false)    
  end

  def self.down
    remove_column(:preferences, :download_notifications)
    remove_column(:preferences, :show_progress_bar)    
  end
end

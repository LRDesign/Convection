class AddDownloadNotiicationsToPreferences < ActiveRecord::Migration
  def self.up
    add_column(:preferences, :download_notifications, :boolean, :default => true)
  end

  def self.down
    remove_column(:preferences, :download_notifications)
  end
end

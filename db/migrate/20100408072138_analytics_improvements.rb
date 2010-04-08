class AnalyticsImprovements < ActiveRecord::Migration
  def self.up
    add_column :preferences, :google_tracking_code, :string
    add_column :preferences, :google_analytics_type, :string
  end

  def self.down
    remove_column :preferences, :google_tracking_code
    remove_column :preferences, :google_analytics_type
  end
end

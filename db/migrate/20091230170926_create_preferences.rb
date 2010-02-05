class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.string :domain
      t.string :site_name
      t.string :smtp_server
      t.integer :smtp_port
      t.boolean :smtp_uses_tls
      t.string :smtp_username
      t.string :smtp_password
      t.boolean :upload_notifications, :allow_nil => false, :default => true
      t.string  :admin_email
      t.boolean :allow_password_resets, :allow_nil => false, :default => true
      t.boolean :require_ssl
      t.integer :maximum_file_size   # in MB      
      t.text :analytics
      t.string :logo_url

      t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end

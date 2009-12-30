class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.string :domain
      t.string :site_name
      t.string :smtp_server
      t.integer :smtp_port
      t.boolean :smtp_uses_ssl
      t.string :smtp_username
      t.string :smtp_password
      t.boolean :email_notifications
      t.text :analytics
      t.string :logo_url

      t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end

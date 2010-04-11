class CreateLogEntries < ActiveRecord::Migration
  def self.up
    create_table :log_entries do |t|
      t.integer :user_id
      t.string :action
      t.datetime :created_at
      t.datetime :updated_at
      t.string :item_type
      t.integer :source_id
      t.string :table
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :log_entries
  end
end

class CreateLogEntries < ActiveRecord::Migration
  def self.up
    create_table :log_entries do |t|
      t.integer :user_id
      t.string :action
      t.integer :document_id
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :log_entries
  end
end

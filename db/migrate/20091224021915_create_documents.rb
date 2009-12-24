class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :data_file_name
      t.string :data_content_type
      t.string :data_size
      t.datetime :data_updated_at
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end

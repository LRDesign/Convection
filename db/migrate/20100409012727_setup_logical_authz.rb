class SetupLogicalAuthz < ActiveRecord::Migration
  def self.up  
    # check for table existence in case we are migrating an existing deployment that
    # already has this table.
    unless table_exists?(:groups)
      create_table :groups do |t|  
        t.string :name  
        t.timestamps  
      end  
    end
    
    # check for table existence in case we are migrating an existing deployment that
    # already has this table.
    unless table_exists?(:permissions)
      create_table :permissions do |t|
        t.references :group
        t.string :controller
        t.string :action
        t.integer :subject_id
        t.timestamps
      end
    end
    
    # check for table existence in case we are migrating an existing deployment that
    # already has this table.
    unless table_exists?(:groups_users)
      create_table :groups_users, :id => false do |t|  
        t.references :user  
        t.references :group  
        t.timestamps  
      end  
    end
  end  

  def self.down  
    drop_table :groups  
    drop_table :groups_users
    drop_table :permissions
  end
  
  def self.table_exists?(name)
    ActiveRecord::Base.connection.tables.include?(name.to_s)
  end
  
end

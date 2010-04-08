ActiveRecord::Schema.define(:version => 0) do
  create_table :az_accounts, :force => true do |t|
    t.string :name
  end

  create_table :groups, :force => true do |t|
    t.string :name
  end

  create_table :az_accounts_groups, :force => true, :id => false do |t|  
    t.references :az_account
    t.references :group  
    t.timestamps  
  end  

  create_table :permissions, :force => true do |t|
    t.references :group
    t.string :controller
    t.string :action
    t.integer :subject_id
  end
end

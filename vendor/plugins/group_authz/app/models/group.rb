class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :permissions
  
  def self.admin_group
    self.find_by_name('Administration')
  end  

  def self.account_column=(account_column_name)
    has_and_belongs_to_many account_column_name
  end
end

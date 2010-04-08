class Group < ActiveRecord::Base
  has_and_belongs_to_many :az_accounts
  has_many :permissions
end

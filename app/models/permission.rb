class Permission < ActiveRecord::Base
  belongs_to :group
end

# == Schema Information
#
# Table name: permissions
#
#  id         :integer(4)      not null, primary key
#  group_id   :integer(4)
#  controller :string(255)
#  action     :string(255)
#  subject_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#


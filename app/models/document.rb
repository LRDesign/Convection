class Document < ActiveRecord::Base       
  has_attached_file :data, :path => ":rails_root/file-storage/:attachment/:id/:style/:filename"
  belongs_to :user                     
  validates_attachment_presence :data  
end

class Document < ActiveRecord::Base       
  has_attached_file :data                 
  belongs_to :user                     
  validates_attachment_presence :data  
end

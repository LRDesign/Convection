class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :permissions

  has_and_belongs_to_many :members, :class_name => <%= user_class.inspect%>

  # returns true if this group can do *action* on *controller* optional object
  def can?(action, controller, object = nil)
    conditions = {
      :group => self,
      :controller => controller,
      :action => action,
      :id => object.id
    }                   
    return LogicalAuthz::is_authorized?(conditions)
  end
  
  # Returns the visible documents that the group has access to
  def visible_documents
    permissions = self.permissions.find(:all, 
                    :conditions => ["controller = ? AND action = ?", "documents", "show"])
    ids = permissions.collect{|p| p.subject_id}
    Document.find(:all, :conditions => {:id => ids||[]})
  end
  
  class << self
    def admin_group
      self.find_by_name('Administration')
    end  

    attr_reader :member_class
  end

end

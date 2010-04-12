class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :permissions

  def self.member_class=(member_class)
    @member_class = member_class
    has_and_belongs_to_many :members, :class_name => member_class.name
  end

  # returns true if this group can do *action* on *controller* optional object
  def can?(action, controller, object = nil)
    conditions = {
      :controller => controller,
      :action => action,
      :subject_id => nil
    }                   
    return true if self.permissions.find(:first, :conditions => conditions)
    return false if object.nil?
    !self.permissions.find(:first, :conditions => conditions.merge!(:subject_id => object.id)).nil?
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

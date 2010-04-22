class <%=group_class%> < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :<%=permission_table%>

  has_and_belongs_to_many :<%=user_table%>, :class_name => <%= user_class.inspect%>
  alias members <%=user_table%> 

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
  
  class << self
    def admin_group
      self.find_by_name(<%=admin_group.inspect%>)
    end  

    def member_class
      <%= user_class%>
    end
  end

end

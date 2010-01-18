module GroupAuthz
  module Helper
    def authorized?(criteria={})
      current_user = AuthnFacade.current_user

      return false if current_user.blank?

      groups = criteria[:group] ? [criteria[:group]] : current_user.groups

      select_on = {
        :group_id => groups.map{|grp| grp.id},
        :controller => criteria[:controller] || controller_name,
        :action => nil,
        :subject_id => nil
      }

      permissions = Permission.find(:first, :conditions => select_on)
      return true unless permissions.nil?

      select_on[:action] = criteria[:action] || action_name
      permissions = Permission.find(:first, :conditions => select_on)
      return true unless permissions.nil?

      select_on[:subject_id] = criteria[:id] || params["id"]
      permissions = Permission.find(:first, :conditions => select_on)
      return (not permissions.nil?)
    end
  end
end

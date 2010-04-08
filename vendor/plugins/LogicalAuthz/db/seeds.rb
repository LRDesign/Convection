admin_group = Group.create!(
  :name => "Administration"
)

module GroupAuthz
  module PermissionSeeds
    def self.create_permission(user, controller, action = nil, subject_id = nil)
      GroupAuthz::Permission.create!(
        :group_id => user.id,
        :controller => controller,
        :action => action,
        :subject_id => subject_id
      )
    end

    #create_permission(admin_group, "admin/permissions")
  end
end

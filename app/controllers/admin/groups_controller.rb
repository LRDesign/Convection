module Admin                           
  # This is pulled from the GroupAuthz plugin
  GroupsController = ::GroupsController 
  GroupsController.prepend_view_path('app/views/admin')
end

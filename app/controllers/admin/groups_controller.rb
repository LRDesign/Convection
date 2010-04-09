module Admin                           
  GroupsController = ::GroupsController 
  GroupsController.prepend_view_path('app/views/admin')
end

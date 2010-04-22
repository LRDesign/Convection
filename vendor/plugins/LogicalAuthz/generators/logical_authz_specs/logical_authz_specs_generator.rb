class LogicalAuthzSpecsGenerator < LogicalAuthz::Generator
  default_options(:permission_class => "Permission", 
                  :group_class => "Group",
                  :admin_group => "Administration")

  def manifest
    record do |manifest|
      manifest.directory "spec/factories"
      manifest.directory "spec/support"
      manifest.directory "spec/controllers"
      manifest.directory "spec/helpers"

      manifest.template "spec/factories/az_accounts.rb.erb", "spec/factories/logical_authz_#{template_data[:user_table]}.rb", :assigns => template_data
      manifest.template "spec/support/spec_helper.rb.erb", "spec/support/spec_helper.rb", :assigns => template_data
      manifest.template "spec/support/mock_auth.rb.erb", "spec/support/mock_auth.rb", :assigns => template_data
      manifest.template "spec/controllers/permissions_controller_spec.rb.erb", "spec/controllers/#{template_data[:permission_table]}_controller_spec.rb", :assigns => template_data
      manifest.template "spec/controllers/groups_controller_spec.rb.erb", "spec/controllers/#{template_data[:group_table]}_controller_spec.rb", :assigns => template_data
      manifest.template "spec/controllers/groups_users_controller_spec.rb.erb", "spec/controllers/#{template_data[:group_table]}_#{template_data[:user_table]}_controller_spec.rb", :assigns => template_data
      manifest.template "spec/helpers/logical_authz_helper_spec.rb.erb", "spec/helpers/logical_authz_helper_spec.rb", :assigns => template_data
    end
  end
end

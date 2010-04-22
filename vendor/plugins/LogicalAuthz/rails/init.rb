ActionView::Base.send :include, LogicalAuthz::Helper
#This is maybe slightly unfriendly - we won't be offended if you delete it from 
#your local copies of the gem.  A configuration is coming in a near future 
#version.  When you get weird errors like "can't dup nil!" in development that 
#aren't there in production, don't blame us
[controller_path, File::join(directory, "app", "helpers")].each do |reloaded_path|
  ActiveSupport::Dependencies::load_once_paths.delete(reloaded_path)
end

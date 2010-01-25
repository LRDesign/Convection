# Install hook code here

require 'ftools'



File.mkdir_p File.join(root_dir, 'public', 'stylesheets', 'sass') 

install_file File.join(lrd_view_tools_dir, 'stylesheets', 'reset.css'), File.join(root_dir, 'public', 'stylesheets', 'reset.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'debug.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'debug.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'constants.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'constants.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'screen.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'screen.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'universal.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'universal.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'utility.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'utility.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'print.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'print.sass')

install_file File.join(lrd_view_tools_dir, 'images', 'blank.gif'), File.join(root_dir, 'public', 'images', 'blank.gif')
install_file File.join(lrd_view_tools_dir, 'images', 'check.png'), File.join(root_dir, 'public', 'images', 'check.png')


def install_file(source,dest)   
  plugins_dir = File.expand_path(".")
  lrd_view_tools_dir = File.join(plugins_dir, 'lrd_view_tools')
  root_dir = File.join(lrd_view_tools_dir, '..', '..', '..')
  
  if File.exists?(dest)
    p "Not installing #{dest}, file exists"   
  else 
    File.copy(source, dest)
  end    
end
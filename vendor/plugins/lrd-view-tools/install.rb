# Install hook code here

require 'ftools'            
require 'fileutils'

# plugins_dir = File.expand_path(__FILE__)
lrd_view_tools_dir = File.dirname(__FILE__)
root_dir = File.join(lrd_view_tools_dir, '..', '..', '..')

def install_file(source,dest)   
  if File.exists?(dest)
    puts "\tExists:     #{dest}"   
  else           
    puts "\tInstalling: #{dest}"
    File.copy(source, dest)
  end    
end                   

def ensure_directory(dir)
  puts "\tCreating directory #{dir} "
  FileUtils.mkdir_p dir
end          

ensure_directory(File.join(root_dir, 'public', 'stylesheets', 'sass'))

install_file File.join(lrd_view_tools_dir, 'stylesheets', 'reset.css'), File.join(root_dir, 'public', 'stylesheets', 'reset.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'debug.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'debug.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'constants.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'constants.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'screen.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'screen.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'universal.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'universal.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'utility.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'utility.sass')
install_file File.join(lrd_view_tools_dir, 'stylesheets', 'sass', 'print.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'print.sass')

install_file File.join(lrd_view_tools_dir, 'images', 'blank.gif'), File.join(root_dir, 'public', 'images', 'blank.gif')
install_file File.join(lrd_view_tools_dir, 'images', 'check.png'), File.join(root_dir, 'public', 'images', 'check.png')

ensure_directory(File.join(root_dir, 'app', 'views', 'shared'))

install_file File.join(lrd_view_tools_dir, 'views', 'shared', '_block.html.haml'), File.join(root_dir, 'app','views', 'shared', '_block.html.haml')

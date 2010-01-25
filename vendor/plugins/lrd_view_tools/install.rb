# Install hook code here

require 'ftools'

plugins_dir = File.expand_path(".")
lrd_view_tools_dir = File.join(plugins_dir, 'lrd_view_tools')
root_dir = File.join(lrd_view_tools_dir, '..', '..', '..')

File.copy File.join(lrd_view_tools_dir, 'stylesheets', 'debug.sass'), File.join(root_dir, 'public', 'stylesheets', 'sass', 'debug.sass')
File.copy File.join(lrd_view_tools_dir, 'images', 'blank.gif'), File.join(root_dir, 'public', 'images', 'blank.gif')
File.copy File.join(lrd_view_tools_dir, 'images', 'check.png'), File.join(root_dir, 'public', 'images', 'check.png')
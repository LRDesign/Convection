module NavHelper

  def menu_item(name, path)     
    cssclass = current_page?(path) ? 'selected' : 'unselected'
    content_tag :li, link_to(name, path), :class => cssclass
  end
  
  def menu_items
    menu_items = []    
    if current_user
      menu_items << menu_item("Downloads", documents_path )
      menu_items << menu_item("My Uploads", "/uploads" )
      menu_items << menu_item("Account", edit_user_path(current_user) )
      menu_items << menu_item("Log Out", logout_path)
    else
      menu_items << menu_item("Log In", login_path)
    end  
    menu_items
  end     


end
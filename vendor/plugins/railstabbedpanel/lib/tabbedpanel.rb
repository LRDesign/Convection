# Copyright 2007 New Medio.  This file is part of RailsTabbedPanel.  For more information see the README file.


# TODO:
#  * maybe do the same with an index/offset so you don't have to know the tab base id
#  * should have some documentation on how to get the select function out and use it elsewhere.

module TabbedPanel
  module TabbedPanelHelper
    def tabbed_panel(opts={}, &block)
      tabctx = TabbedContext.new(self, opts)
      if block_given?
        extra_html = capture(tabctx, &block)
        concat(tabctx.render, block.binding)
        concat(extra_html, block.binding)
      end

      return tabctx
    end
  end

  class TabbedContext
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::JavaScriptHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::TagHelper

    def initialize(view, opts = {})
      @view = view
      @default_first_tab_active = opts[:default_first_tab_active].nil? ? true : opts[:set_first_tab_active]
      @active_panel = opts[:active_panel]
      @tracking_function = (opts[:tracking].nil? || opts[:tracking] == false) ? nil : (opts[:tracking] == true ? "urchinTracker" : opts[:tracking])
      @has_active_panel = false
      @base_name = opts[:base] || idgen('tabbed_panel')
      @tab_class = opts[:tab_class] || 'panel_tab'
      @tab_unselected_class = opts[:tab_unselected_class] || 'tab_unselected'
      @tab_selected_class = opts[:tab_selected_class] || 'tab_selected'
      @tab_container_class = opts[:tab_container_class] || 'tab_container'
      @container_class = opts[:container_class] || 'tabbed_panel'
      @container_id = opts[:container_id] || @base_name
      @panel_class = opts[:panel_class] || 'panel_panel'
      @panel_unselected_class = opts[:panel_unselected_class] || 'panel_unselected'
      @panel_selected_class = opts[:panel_selected_class] || 'panel_selected'
      @panel_container_class = opts[:panel_container_class] || 'panel_panels'

      @select_function_name = opts[:select_function_name]||idgen

      @panels = []
    end

    def output_buffer
      @view.output_buffer
    end

    def output_buffer=(val)
      @view.output_buffer = val
    end

    @@gen_id=0

    def idgen(prefix=nil)
      prefix ||= @base_name 
      @@gen_id += 1
      "#{prefix}_#{@@gen_id}"
    end

    def function_name
      return @select_function_name
    end

    def panel(panel_name, opts = {}, &block)
      ## Get the base ID of the panel ##
      panel_base_id = opts[:base_id]||idgen

      ## Determin if the panel should start active ##
      if @has_active_panel
        panel_active = false
      elsif opts[:active] 
        panel_active = true
        @has_active_panel = true  #No other panels can be active now
      elsif @active_panel == panel_base_id  
        panel_active = true
        @has_active_panel = true  #No other panels can be active now
      else
        panel_active = false
      end

      ## Grab the content for the panel ##
      if opts[:content].nil?
        panel_html = capture(&block)
      else
        panel_html = opts[:content]
      end
      
      @panels.push({
          :base_id => panel_base_id,
          :name => panel_name,
          :content => panel_html,
          :active => panel_active,
          :panel_class => opts[:panel_class],
          :tab_class => opts[:tab_class],
          :tracking_uri => opts[:tracking_uri]
        })	
    end

    def render(&block)
      str = "<div class='#{@container_class}' id='#{@container_id}'>\n"
      str += "<ul class='#{@tab_container_class}' id='#{@base_name}_tabs'>\n"
      
      if @default_first_tab_active && (!@has_active_panel)
        if @panels.size > 0
          @panels[0][:active] = true
        end
      end
    
      @panels.each do |panel|
        str += "<li class='#{@tab_class} #{panel[:active] ? @tab_selected_class : @tab_unselected_class} #{panel[:tab_class]}' id='#{panel[:base_id]}_tab'>" + link_to_function(panel[:name], "document.#{@select_function_name}('#{panel[:base_id]}')") + "</li>"
      end

      str += "</ul>\n"
      str += "<ul class='#{@panel_container_class}' id='#{@base_name}_panels'>\n"

      @panels.each do |panel|
        str += "<li class='#{@panel_class} #{panel[:active] ? @panel_selected_class : @panel_unselected_class} #{panel[:panel_class]}' id='#{panel[:base_id]}_panel'>" + panel[:content] + "</li>\n"
      end
      str += "</ul>\n"
      str += "</div>\n"

      #Note - attaching it to document is required for some of the wierd scope rules that apply to Ajax
      js_code = "document.#{@select_function_name} = function(base_id) {\ntmp_tracking_uri = '';\n"
      
      @panels.each do |panel|
        js_code += "tmp_tab = $('#{panel[:base_id]}_tab');\n"
        js_code += "tmp_panel = $('#{panel[:base_id]}_panel');\n"
        js_code += "if(base_id == '#{panel[:base_id]}') { \n tmp_panel.removeClassName('#{@panel_unselected_class}'); tmp_tab.removeClassName('#{@tab_unselected_class}'); tmp_tab.addClassName('#{@tab_selected_class}'); tmp_panel.addClassName('#{@panel_selected_class}'); tmp_tracking_uri = '#{panel[:tracking_uri]}'; \n} else {\n tmp_panel.removeClassName('#{@panel_selected_class}'); tmp_tab.removeClassName('#{@tab_selected_class}'); tmp_tab.addClassName('#{@tab_unselected_class}'); tmp_panel.addClassName('#{@panel_unselected_class}'); \n}"
      end
      
      #Do the actual tracking as the last thing, in case it errors out.
      unless @tracking_function.nil?
        js_code += "\nif(tmp_tracking_uri != '') { #{@tracking_function}(tmp_tracking_uri); }"
      end

      js_code += "}\n"
      
      ## NOTE - this is for backwards-compatibility.  Should be marked as deprecated
      js_code += "function #{@select_function_name}(base_id) { return document.#{@select_function_name}(base_id); }"

      str += javascript_tag(js_code)

      return str
    end
  end
end

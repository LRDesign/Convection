# Copyright 2007 New Medio.  This file is part of RailsTabbedPanel.  See README for additional information.

require 'tabbedpanel'
ActionView::Base.send(:include, TabbedPanel::TabbedPanelHelper)

require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe <%= controller_class_name %>Controller do

  before(:each) do
    @<%= file_name %> = Factory(:<%= singular_name %>)
  end

  describe "responding to GET index" do

    it "should expose all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      get :index
      assigns[:<%= table_name %>].should == [@<%= file_name %>]
    end

    describe "with mime type of xml" do
  
      it "should render all <%= table_name.pluralize %> as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        <%= class_name %>.should_receive(:find).with(:all).and_return(<%= file_name.pluralize %> = mock("Array of <%= class_name.pluralize %>"))
        <%= file_name.pluralize %>.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested <%= file_name %> as @<%= file_name %>" do
      get :show, :id => @<%= file_name %>.id
      assigns[:<%= file_name %>].should == @<%= file_name %>
    end
    
    describe "with mime type of xml" do

      it "should render the requested <%= file_name %> as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        <%= class_name %>.should_receive(:find).with("37").and_return(@<%= file_name %>)
        @<%= file_name %>.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new <%= file_name %> as @<%= file_name %>" do
      <%= file_name %> = Factory.build(:<%= singular_name %>)
      <%= class_name %>.should_receive(:new).and_return(<%= file_name %>)
      get :new
      assigns[:<%= file_name %>].should equal(<%= file_name %>)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested <%= file_name %> as @<%= file_name %>" do
      get :edit, :id => @<%= file_name %>.id
      assigns[:<%= file_name %>].should == @<%= file_name %>
    end

  end

  describe "responding to POST create" do

    before(:each) do
      @new_<%= file_name %> = Factory.build(:<%= singular_name %>)
    end

    describe "with valid params" do

      it "should expose a newly created <%= file_name %> as @<%= file_name %>" do
        <%= class_name %>.should_receive(:new).with({'these' => 'params'}).and_return(@new_<%= file_name %>)
        post :create, :<%= file_name %> => {:these => 'params'}
        assigns(:<%= file_name %>).should equal(@new_<%= file_name %>)
      end

      it "should redirect to the created <%= file_name %>" do
        <%= class_name %>.stub!(:new).and_return(@new_<%= file_name %>)
        post :create, :<%= file_name %> => {}
        response.should redirect_to(<%= table_name.singularize %>_url(@new_<%= file_name %>))
      end
      
    end
    
    describe "with invalid params" do

      before(:each) do
        @new_<%= file_name %>.stub!(:save => false)
      end

      it "should expose a newly created but unsaved <%= file_name %> as @<%= file_name %>" do
        <%= class_name %>.stub!(:new).with({'these' => 'params'}).and_return(@new_<%= file_name %>)
        post :create, :<%= file_name %> => {:these => 'params'}
        assigns(:<%= file_name %>).should equal(@new_<%= file_name %>)
      end

      it "should re-render the 'new' template" do
        <%= class_name %>.stub!(:new).and_return(@new_<%= file_name %>)
        post :create, :<%= file_name %> => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    before(:each) do
      <%= class_name %>.should_receive(:find).with(@<%= file_name%>.id.to_s).and_return(@<%= file_name %>)
    end

    it "should update the requested <%= file_name %>" do
      @<%= file_name %>.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => @<%= file_name %>.id, :<%= file_name %> => {:these => 'params'}
    end

    describe "with valid params" do

      before(:each) do
        @<%= file_name %>.stub!(:update_attributes => true)
      end

      it "should expose the requested <%= file_name %> as @<%= file_name %>" do
        put :update, :id => @<%= file_name %>.id
        assigns(:<%= file_name %>).should equal(@<%= file_name %>)
      end

      it "should redirect to the <%= file_name %>" do
        put :update, :id => @<%= file_name %>.id
        response.should redirect_to(<%= table_name.singularize %>_url(@<%= file_name %>))
      end

    end
    
    describe "with invalid params" do

      before(:each) do
        @<%= file_name %>.stub!(:update_attributes => false)
      end

      it "should expose the <%= file_name %> as @<%= file_name %>" do
        put :update, :id => @<%= file_name %>.id
        assigns(:<%= file_name %>).should equal(@<%= file_name %>)
      end

      it "should re-render the 'edit' template" do
        put :update, :id => @<%= file_name %>.id
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested <%= file_name %>" do
      <%= class_name %>.should_receive(:find).with(@<%= file_name %>.id.to_s).and_return(@<%= file_name %>)
      @<%= file_name %>.should_receive(:destroy)
      delete :destroy, :id => @<%= file_name %>.id
    end
  
    it "should redirect to the <%= table_name %> list" do
      delete :destroy, :id => @<%= file_name %>.id
      response.should redirect_to(<%= table_name %>_url)
    end

  end

end

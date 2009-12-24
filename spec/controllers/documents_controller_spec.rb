require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocumentsController do      

  before(:each) do  
    activate_authlogic 
    login_as(:quentin)    
    @document = Factory(:document)
  end

  describe "responding to GET index" do

    it "should expose all documents as @documents" do
      get :index
      assigns[:documents].should == [@document]
    end

    describe "with mime type of xml" do
  
      it "should render all documents as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Document.should_receive(:find).with(:all).and_return(documents = mock("Array of Documents"))
        documents.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested document as @document" do
      get :show, :id => @document.id
      assigns[:document].should == @document
    end
    
    describe "with mime type of xml" do

      it "should render the requested document as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Document.should_receive(:find).with("37").and_return(@document)
        @document.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new document as @document" do
      document = Factory.build(:document)
      Document.should_receive(:new).and_return(document)
      get :new
      assigns[:document].should equal(document)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested document as @document" do
      get :edit, :id => @document.id
      assigns[:document].should == @document
    end

  end

  describe "responding to POST create" do

    before(:each) do
      @new_document = Factory.build(:document)
    end

    describe "with valid params" do

      it "should expose a newly created document as @document" do
        Document.should_receive(:new).with({'these' => 'params'}).and_return(@new_document)
        post :create, :document => {:these => 'params'}
        assigns(:document).should equal(@new_document)
      end

      it "should redirect to the created document" do
        Document.stub!(:new).and_return(@new_document)
        post :create, :document => {}
        response.should redirect_to(document_url(@new_document))
      end
      
    end
    
    describe "with invalid params" do

      before(:each) do
        @new_document.stub!(:save => false)
      end

      it "should expose a newly created but unsaved document as @document" do
        Document.stub!(:new).with({'these' => 'params'}).and_return(@new_document)
        post :create, :document => {:these => 'params'}
        assigns(:document).should equal(@new_document)
      end

      it "should re-render the 'new' template" do
        Document.stub!(:new).and_return(@new_document)
        post :create, :document => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    before(:each) do
      Document.should_receive(:find).with(@document.id.to_s).and_return(@document)
    end

    it "should update the requested document" do
      @document.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => @document.id, :document => {:these => 'params'}
    end

    describe "with valid params" do

      before(:each) do
        @document.stub!(:update_attributes => true)
      end

      it "should expose the requested document as @document" do
        put :update, :id => @document.id
        assigns(:document).should equal(@document)
      end

      it "should redirect to the document" do
        put :update, :id => @document.id
        response.should redirect_to(document_url(@document))
      end

    end
    
    describe "with invalid params" do

      before(:each) do
        @document.stub!(:update_attributes => false)
      end

      it "should expose the document as @document" do
        put :update, :id => @document.id
        assigns(:document).should equal(@document)
      end

      it "should re-render the 'edit' template" do
        put :update, :id => @document.id
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested document" do
      Document.should_receive(:find).with(@document.id.to_s).and_return(@document)
      @document.should_receive(:destroy)
      delete :destroy, :id => @document.id
    end
  
    it "should redirect to the documents list" do
      delete :destroy, :id => @document.id
      response.should redirect_to(documents_url)
    end

  end

end

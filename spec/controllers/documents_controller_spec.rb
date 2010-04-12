require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocumentsController, "with authz restrictions" do
  before(:each) do
    @admins = Factory.create(:admins)    
  end
  
  describe "uploading" do
    before do 
      activate_authlogic

      @user = Factory(:user)
      login_as(@user)
    end

    describe "with permission on :new" do
      before do 
        group = Factory(:group)
        @user.groups << group

        Factory(:permission, :group => group, :controller => "documents", :action => "new")
      end
      
      it "should generate uuid" do
        document = Factory.build(:document)
        Document.should_receive(:new).and_return(document)
        get :new
        
        assigns[:uuid].should_not be_blank
      end

      it "should allow access to new" do
        document = Factory.build(:document)
        Document.should_receive(:new).and_return(document)
        get :new
        controller.should be_authorized
        assigns[:document].should equal(document)
      end

      describe "responding to POST create" do

        before(:each) do
          @new_document = Factory.create(:document)
          Document.stub!(:new).and_return(@new_document)
        end

        it "should be authorized" do
          post :create, :document => {:these => 'params'}
          controller.should be_authorized
        end

        describe "with valid params" do
          it "should expose a newly created document as @document" do
            post :create, :document => {:these => 'params'}
            assigns(:document).should equal(@new_document)
          end

          it "should redirect to the created document" do
            post :create, :document => {}
            response.should redirect_to(document_url(@new_document))
          end
          
          it "should create a new document and add a log entry" do
            lambda do
              post :create, :document => {:these => 'params'}
              assigns(:document).should equal(@new_document)
            end.should change{LogEntry.count}.by(1)
          end
                    
          describe "if upload_notifications is turned on" do
            it "should generate an email" do    
              Preferences.find(:first).update_attributes(:upload_notifications => true) 
              lambda do
                post :create, :document => {}
              end.should change{ ActionMailer::Base.deliveries.size }.by(1)
            end
          end 
          
          it "should give admins show permissions on the doc" do
            post :create, :document => {:these => 'params'}
            @admins.should be_can('show', 'documents', @new_document)
          end
          
          it "should give admins edit permissions on the doc" do
            post :create, :document => {:these => 'params'}
            @admins.should be_can('edit', 'documents', @new_document)
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
    end

    describe "without permission on :new" do
      it "should not allow acces to new" do
        get :new
        controller.should be_forbidden
      end

      it "should not allow access to create" do
        post :create, :document => "whatever"
        controller.should be_forbidden
      end
    end
  end

  describe "downloading" do
    before do
      activate_authlogic

      user = Factory(:user)
      login_as(user)

      group = Factory(:group)
      user.groups << group
      Factory(:permission, :group => group, :controller => "documents", :action => "new")

      @new_document = Factory.create(:document)

      Document.stub!(:new).and_return(@new_document)
      post :create, :document => {:these => 'params'}
    end

    it "should allowed for uploader" do
      controller.stub!(:send_file).with("#{RAILS_ROOT}/file-storage/datas/#{@new_document.id}/original/value for data_file_name.").and_return(nil)
      get :download, :id => @new_document.id

      controller.should be_authorized
      response.should be_success
    end
    
    it "should fire off an email" do
      lambda do
        controller.stub!(:send_file).with("#{RAILS_ROOT}/file-storage/datas/#{@new_document.id}/original/value for data_file_name.").and_return(nil)
        get :download, :id => @new_document.id

        controller.should be_authorized
      end.should change{ ActionMailer::Base.deliveries.size }.by(1)      
    end

    it "should forbidden to other users" do
      logout

      user = Factory(:user, :name => "Robert Rodriguez")
      login_as(user)

      get :download, :id => @new_document.id

      controller.should be_forbidden
    end
  end
end

describe DocumentsController do      
  before(:each) do  
    activate_authlogic 
    @user = login_as(Factory.create(:user))    
    @group = Factory(:group)
    @admins = Factory.create(:admins)    
    @user.groups << @group
    @other = Factory.create(:user)
    @document = Factory.create(:document)
  end

  describe "responding to GET index" do

    it "should include documents the user owns" do
      @document.user = @user
      @document.save!
      get :index
      assigns[:documents].should == [@document]
    end 

    describe "for documents created by someone else" do
      before(:each) do
        @document.user = @other
        @document.save!        
      end

      it "should not include the docs if the user can't access" do
        get :index
        assigns[:documents].should_not include(@document)
      end

      it "should include the docs if the user's group has access" do
        @user.groups << ( @group = Factory(:group))
        @user.save!
        Permission.create!(:controller => 'documents', :action => 'show', :group_id => @group.id, :subject_id => @document.id)
        get :index
        assigns[:documents].should include(@document)
      end
    end

    describe "with mime type of xml" do

      it "should render all documents as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Document.should_receive(:find).with(:all).and_return(documents = mock("Array of Documents"))
        documents.should_receive(:select).and_return(documents)
        documents.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET show" do
    before do
      Factory(:permission, :group => @group, :controller => "document", :action => "show")
    end

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

  describe "responding to GET edit" do
    before do
      Factory(:permission, :group => @group, :controller => "document", :action => "edit")
    end

    it "should expose the requested document as @document" do
      get :edit, :id => @document.id
      assigns[:document].should == @document
    end
    
    it "should generate uuid" do
      get :edit, :id => @document.id
      assigns[:uuid].should_not be_blank
    end    

  end

  describe "responding to POST create" do

    before(:each) do
      @new_document = Factory.build(:document)
    end

    
    
  end

  describe "responding to PUT update" do

    before(:each) do
      Document.should_receive(:find).twice.with(@document.id.to_s).and_return(@document)
      Factory(:permission, :group => @group, :controller => "documents", :action => "edit")
    end

    it "should update the requested document" do
      @document.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => @document.id, :document => {:these => 'params'}
      controller.should be_authorized
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
        controller.should be_authorized
      end

    end

    describe "with invalid params" do

      before(:each) do
        @document.stub!(:update_attributes => false)
      end

      it "should expose the document as @document" do
        put :update, :id => @document.id
        controller.should be_authorized
        assigns(:document).should equal(@document)
      end

      it "should re-render the 'edit' template" do
        put :update, :id => @document.id
        controller.should be_authorized
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do
    before do
      Factory(:permission, :group => @group, :controller => "documents", :action => "destroy")
    end

    it "should destroy the requested document" do
      Document.should_receive(:find).with(@document.id.to_s).and_return(@document)
      @document.should_receive(:destroy)
      delete :destroy, :id => @document.id
      controller.should be_authorized
    end

    it "should redirect to the documents list" do
      delete :destroy, :id => @document.id
      controller.should be_authorized
      response.should redirect_to(documents_url)
    end

  end

end

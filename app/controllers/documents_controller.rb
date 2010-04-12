class DocumentsController < ApplicationController
  before_filter :find_document, :only => [ :show, :edit, :update, :destroy ] 
  before_filter :remember_prior, :only => [:update]
  before_filter :initialize_uuid, :only => [:new, :edit]
  before_filter :require_user

  needs_authorization :download, :edit, :update, :new, :create, :destroy
  grant_aliases :edit => [:update, :destroy], :new => :create, :show => :download
  admin_authorized :edit
  
  dynamic_authorization do |user, criteria|
    case criteria[:action]
    when "download"
      doc = Document.find(criteria[:id].to_i)
      return false if doc.nil?
      return true if doc.user == user
    end
    return false
  end

  # GET /documents
  # GET /documents.xml
  def index
    @documents = Document.find(:all).select{ |doc| current_user.can?(:show, doc) }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end

  def download
    find_document
    Notifier.deliver_download_notification(@document) if @preferences.download_notifications?    
    send_file(@document.data.path)
  end

  # GET /documents/new
  # GET /documents/new.xml
  def new
    @document = Document.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.xml
  def create
    @document = Document.new(params[:document])
    @document.user = current_user

    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully created.'
        save_log(@document)
        Notifier.deliver_upload_notification(@document) if @preferences.upload_notifications?
        debugger if Group.admin_group.nil?
        ['show', 'edit'].each do |action|
           Permission.create( :action => action, :controller => 'documents', :subject_id => @document.id, :group_id => Group.admin_group.id )
        end
        format.html { redirect_to(@document) }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    respond_to do |format|
      if @document.update_attributes(params[:document])
        save_log(@old_document, @document)
        flash[:notice] = 'Document was successfully updated.'
        format.html { redirect_to(@document) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.xml
  def destroy
    @document.destroy
    #TODO delete the file from disk
    respond_to do |format|
      format.html { redirect_to(documents_url) }
      format.xml  { head :ok }
    end
  end

  private
  def initialize_uuid
    @uuid = ''
    (0..29).to_a.map{|x| rand(10)}.each{|i| @uuid = "#{@uuid}#{i}"}    
  end
  
  def remember_prior
    @old_document = Document.find(params[:id])
  end
  
  def find_document
    @document = Document.find(params[:id]) rescue nil
    raise ArgumentError, 'Invalid document id provided' unless @document
  end
end

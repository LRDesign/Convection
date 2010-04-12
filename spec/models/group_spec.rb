require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Group do 
  describe 'visible_documents' do
    before :each do
      @group = Factory.create(:some_guys)
    end
  
    it "should return visible documents" do
      d = Factory.create(:document, {:name => "Hello Governor"})
      @group.permissions << Factory.create(:base_permission, {:controller => 'documents', :action => 'show', :subject_id => d.id})
      @group.save!
      @group.reload.visible_documents.should be_include(d)
    end
  
    it "should return empty array if no visible documents" do
      @group.visible_documents.should be_empty
    end
  end
end
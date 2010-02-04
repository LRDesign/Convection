# == Schema Information
#
# Table name: documents
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)
#  description       :text
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer(4)
#  data_updated_at   :datetime
#  user_id           :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'digest'
require 'fileutils'

describe Document do
  before(:each) do
    @file = File.new(File.join(File.dirname(__FILE__),
                               "..",
                               "fixtures",
                               "5k.png"), 'rb')

    @valid_attributes = {
      :name => "a_file",
      :description => "value for description",
      :data => @file,
      :user_id => "1"
    }
    @doc = Document.create!(@valid_attributes)
  end


  after do
    @file.close
    FileUtils::rm_rf("#{RAILS_ROOT}/file-storage/datas/#{@doc.id}") unless @doc.nil?
  end

  it "should create a new instance given valid attributes" do
    @doc = Document.create!(@valid_attributes)

    source_sum = Digest::SHA512::file(@file.path)
    dest_sum = nil
    proc do
      dest_sum = Digest::SHA512::file("#{RAILS_ROOT}/file-storage/datas/#{@doc.id}/original/5k.png")
    end.should_not raise_error

    dest_sum.should == source_sum
  end

  it "should delete uploaded files when deleted" do
    @doc.destroy
    proc do
      File::open("#{RAILS_ROOT}/file-storage/datas/#{@doc.id}/original/5k.png")
    end.should raise_error(Errno::ENOENT)
  end

  it "should return the path to the file" do
    @doc.data.path.should == "#{RAILS_ROOT}/file-storage/datas/#{@doc.id}/original/5k.png"
  end
end

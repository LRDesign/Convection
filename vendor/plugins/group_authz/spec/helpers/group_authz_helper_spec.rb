require File.dirname(__FILE__) + '/../spec_helper'
require 'app/helpers/group_authz_helper'

class AuthzController < ActionController::Base
  include GroupAuthz::Application
end

class FooController < AuthzController
end

class BarController < AuthzController
end

class WireController < AuthzController
end

describe GroupAuthz::Helper do
  include GroupAuthz::MockAuth

  it "should refuse authorization to guests" do
    logout
    helper.should_not be_authorized
  end

  describe "should recognize authorized users" do
    before do
      login_as(:authorized)
    end

    it "on a controller level" do
      helper.authorized?(:controller => "foo",
                        :action => "nerf",
                        :id => 7).should == true
    end

    it "on an action level" do
      helper.authorized?(:controller => "bar",
                        :action => "baz",
                        :id => 23).should == true
    end

    it "not on the wrong action level" do
      helper.authorized?(:controller => "bar",
                        :action => "bat",
                        :id => 23).should == false
    end

    it "on a record level" do
      helper.authorized?(:controller => "wire",
                        :action => "vinyl",
                        :id => 1).should == true
    end

    it "not on the wrong record level" do
      helper.authorized?(:controller => "wire",
                        :action => "vinyl",
                        :id => 2).should == false
    end
  end

  describe "should refuse unauthorized users" do
    before do
      login_as(:unauthorized)
    end

    it "on a controller level" do
      helper.authorized?(:controller => "foo",
                        :action => "nerf",
                        :id => 7).should == false
    end

    it "on an action level" do
      helper.authorized?(:controller => "bar",
                        :action => "baz",
                        :id => 23).should == false
    end

    it "on a record level" do
      helper.authorized?(:controller => "wire",
                        :action => "vinyl",
                        :id => 1).should == false
    end
  end
end

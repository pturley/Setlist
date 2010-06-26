require 'spec_helper'

describe UsersController do
  integrate_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_tag 'title', /Sign-up/
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
      User.stub!(:find, @user.id).and_return(@user)
      get :show, :id => @user.id
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_tag("title", /#{@user.name}/)
    end
    
    it "should include the users name" do
      response.should have_tag("h2", /#{@user.name}/)
    end
    
    it "should have a profile picture for the user" do
      response.should have_tag("h2>img", :class => "gravatar")
    end
  end
end

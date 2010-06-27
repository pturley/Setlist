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

  describe "POST 'create" do
    
    describe "failure" do
    
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" } 
        @user = Factory.build(:user, @attr) 
        
        User.stub!(:new).and_return(@user) 
        @user.should_receive(:save).and_return(false)
      end
      
      it "should have the right title" do 
        post :create, :user => @attr 
        response.should have_tag("title", /sign up/i) 
      end
       
      it "should render the 'new' page" do 
        post :create, :user => @attr 
        response.should render_template('new') 
      end
    end
    
    describe "success" do
      
      before(:each) do 
        @attr = { :name => "New User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" } 
        @user = Factory(:user, @attr) 
        
        User.stub!(:new).and_return(@user) 
        @user.should_receive(:save).and_return(true) 
      end 
      
      it "should redirect to the user show page" do 
        post :create, :user => @attr 
        response.should redirect_to(user_path(@user)) 
      end 
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to setlist/i
      end
    end
  end
  
end

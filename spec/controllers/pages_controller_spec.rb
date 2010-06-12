require 'spec_helper'

describe PagesController do
  integrate_views
  
  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end

  describe "GET 'home'" do
    it "should be successful" do
      check_success('home')
    end
    
    it "should have the right title" do
      check_title('home')
    end
  end 

  describe "GET 'contact'" do
    it "should be successful" do
      check_success('contact')
    end
    
    it "should have the right title" do
      check_title('contact')
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      check_success('about')
    end
    
    it "should have the right title" do
      check_title('about')
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      check_success('help')
    end
    
    it "should have the right title" do
      check_title('help')
    end
  end
  
  def check_success(action)
    get action
    response.should be_success
  end
  
  def check_title(action)
    get action 
    response.should have_tag("title", "Setlist | #{action.capitalize}")
  end
  
end

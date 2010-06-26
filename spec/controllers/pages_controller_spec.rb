require 'spec_helper'

describe PagesController do
  integrate_views
  
  describe "Get actions" do
    ["home", "contact", "about", "help"].each do |action|
      it "#{action} should be successful" do
          get action
          response.should be_success
      end
    
      it "#{action}should have a the right title" do
          get action 
          response.should have_tag("title", "Setlist | #{action.capitalize}")
      end
    end
  end
end
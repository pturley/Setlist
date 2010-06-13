require 'spec_helper'

describe "/pages/home" do
  before(:each) do
    render 'pages/home'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p')
  end
end

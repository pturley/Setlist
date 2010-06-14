require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "First Last",
      :email => "username@domain.com"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name=>""))
    no_name_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name_user = User.new(@attr.merge(:name=>("a"*51)))
    long_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email=>""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    valid_addresses = %w[foo@bar.com THA_USER@foo.bar.org first.last@foobar.tw]
    valid_addresses.each do |address|
      valid_user = User.new(@attr.merge(:email=>address))
      valid_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    invalid_addresses = %w[foo@bar,com THA_USERfoo.bar.org first.last@foobar.]
    invalid_addresses.each do |address|
      invalid_user = User.new(@attr.merge(:email=>address))
      invalid_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do 
    uppercase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email=>uppercase_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
end

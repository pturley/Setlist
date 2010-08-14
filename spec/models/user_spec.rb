require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "First Last",
      :email => "username@domain.com",
      :password => "password",
      :password_confirmation => "password"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  describe "Name Validations" do
    it "should require a name" do
      no_name_user = User.new(@attr.merge(:name=>""))
      no_name_user.should_not be_valid
    end
  
    it "should reject names that are too long" do
      long_name_user = User.new(@attr.merge(:name=>("a"*51)))
      long_name_user.should_not be_valid
    end
  end
  
  describe "Email Validations" do
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
  
  describe "Password Validations" do
    before(:each) do
      @user = User.create!(@attr)
    end
     
    it "should require password to be identical to password_confirmation" do
      invalid_user = User.new @attr.merge :password_confirmation => "wrong_password"
      invalid_user.should_not be_valid
    end
    
    it "should require password to be between 6 and 40 characters long" do 
      invalid_passwords = ['', 'a'*5, 'a'*41]
      invalid_passwords.each do |password|
        invalid_user = User.new @attr.merge :password => password, :password_confirmation => password
            invalid_user.should_not be_valid
      end
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
      @user.encrypted_password.should_not be_blank
    end
    
    it "should know if passwords match" do
      @user.has_password?(@attr[:password]).should be_true
      @user.has_password?("invalid").should be_false      
    end
    
    describe "authentication method" do
      it "should return nil if there is no user in the database with the given email" do
        non_existent_user = User.authenticate("alskdf@blah.com", @attr[:password])
        non_existent_user.should be_nil
      end
      
      it "should return nil if the email and password dont match" do
        wrong_password_user = User.authenticate(@attr[:email], "wrong_password")
        wrong_password_user.should be_nil
      end
      
      it "should return the user if email and password match" do
        authenticated_user = User.authenticate(@attr[:email], @attr[:password])
        authenticated_user.should == @user
      end
    end
  end

  describe "Remember Me" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have a remember token" do
      @user.should respond_to(:remember_token)
    end
    
    it "should have a remember_me! method" do
      @user.should respond_to(:remember_me!)
    end
    
    it "should set the remember token" do
      @user.remember_me!
      @user.remember_token.should_not be_nil
    end
  end

end

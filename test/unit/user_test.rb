require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:user_group)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email)
  should validate_confirmation_of(:password)

  # does not seem to work?.. but why?..
  describe User do
    before(:each) { User.create!(:email => 'address@example.com') }
    it { should validate_presence_of(:password) }
  end

  context "testing in an older styl" do
    setup do
      @user = User.new
    end

    should "user validates email correctly" do
      @user.password = "password"
      assert ! @user.valid?
      @user.email = "bob"
      assert ! @user.valid?
      @user.email = "bob@people"
      assert ! @user.valid?
      @user.email = "bob@people.com"
      assert @user.valid?
    end

    context "creating a user" do
      setup do
        @user.email = "bob@people.com"
        @user.password_salt = "$2a$10$rYGIB5FtJ4C2vqwnpFpD/e"
        @user.password = "password"
        @user.save!
      end
      should "have a hashed password" do
        assert_equal "$2a$10$rYGIB5FtJ4C2vqwnpFpD/eenDh462MRIJTT7/SU2wYkTlbVSO5rKW", @user.password_hash
      end
      should "have an API key" do
        assert_equal "1160db5786aa87a3bfa7eed2aa40dd7e6f61331a", @user.api_key
      end
      should "user should authenticate" do
        assert ! User.authenticate( "bob@people.com", "assword" )
        assert User.authenticate( "bob@people.com", "password" )
      end
    end
  end

end

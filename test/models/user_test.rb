require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name:      "Example",
                     last_name:       "User",
                     address_line_1:  "4 Second Street",
                     address_line_2:  "Flat 4",
                     town:            "Glasgow",
                     post_code:       "G12 3AB",
                     tel_no:          "999999999",
                     email:           "example@email.com",
                     password: "password",
                     password_confirmation: "password",
                     type:            "User")
  end

  #
  # PRESENCE VALIDATION
  #

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "        "
    assert_not @user.valid?
  end

  test "last_name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "address_line_1 should be present" do
    @user.address_line_1 = "     "
    assert_not @user.valid?
  end

  test "address_line_2 should be a string" do
    @user.address_line_2 = "Flat 2"
    assert @user.valid?
  end

  test "address_line_2 could be nil" do
    @user.address_line_2 = nil
    assert @user.valid?
  end

  test "town should be present" do
    @user.town = "     "
    assert_not @user.valid?
  end

  test "post_code should be present" do
    @user.post_code = "     "
    assert_not @user.valid?
  end

  test "tel_no should be present" do
    @user.tel_no = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "     "
    assert_not @user.valid?
  end

  test "type should be present" do
    @user.type = "     "
    assert_not @user.valid?
  end

  #
  # LENGTH VALIDATION
  #

  test "first_name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "address_line_1 should not be too long" do
    @user.address_line_1 = "a" * 51
    assert_not @user.valid?
  end
  
  test "address_line_2 should not be too long" do
    @user.address_line_2 = "a" * 51
    assert_not @user.valid?
  end

  test "town should not be too long" do
    @user.town = "a" * 51
    assert_not @user.valid?
  end

  test "post_code should not be too long" do
    @user.post_code = "a" * 11
    assert_not @user.valid?
  end

  test "tel_no should not be too long" do
    @user.tel_no = "a" * 15
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 51
    assert_not @user.valid?
  end

  # test "password_digest should not be too long" do
  #   @user.password_digest = "a" * 257
  #   assert_not @user.valid?
  # end

  test "type should not be too long" do
    @user.type = "MembershipClerk1"
    assert_not @user.valid?
  end

  #
  # UNIQUENESS
  #

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  #
  # AUTHENTICATION
  #

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end

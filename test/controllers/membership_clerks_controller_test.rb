require 'test_helper'

class MembershipClerksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership_clerk = membership_clerks(:membership_clerk_one)
  end

  test "should get index" do
    get membership_clerks_url
    assert_response :success
  end

  test "should get new" do
    get new_membership_clerk_url
    assert_response :success
  end

  test "should create membership_clerk" do
    assert_difference('MembershipClerk.count') do
      post membership_clerks_url, params: { membership_clerk: { address_line_1: "2 Water Avenue", 
                                                                address_line_2: nil, 
                                                                email: "membershipclerk@readall.com", 
                                                                first_name: "Matthew", 
                                                                last_name: "Clerk", 
                                                                password: "password999", 
                                                                password_confirmation: "password999",
                                                                post_code: "PA1 9IK", 
                                                                tel_no: "07549284758", 
                                                                town: "Paisley", 
                                                                type: "MembershipClerk" } }
    end

    assert_redirected_to membership_clerk_url(MembershipClerk.last)
  end

  test "should show membership_clerk" do
    get membership_clerk_url(@membership_clerk)
    assert_response :success
  end

  test "should get edit" do
    get edit_membership_clerk_url(@membership_clerk)
    assert_response :success
  end

  test "should update membership_clerk" do
    patch membership_clerk_url(@membership_clerk), params: { membership_clerk: { address_line_1: @membership_clerk.address_line_1, 
                                                                                 address_line_2: @membership_clerk.address_line_2, 
                                                                                 email: @membership_clerk.email, 
                                                                                 first_name: @membership_clerk.first_name, 
                                                                                 last_name: @membership_clerk.last_name, 
                                                                                 password: "password111", 
                                                                                 password_confirmation: "password111",
                                                                                 post_code: @membership_clerk.post_code, 
                                                                                 tel_no: @membership_clerk.tel_no, 
                                                                                 town: @membership_clerk.town, 
                                                                                 type: @membership_clerk.type } }
    assert_redirected_to membership_clerk_url(@membership_clerk)
  end

  test "should destroy membership_clerk" do
    assert_difference('MembershipClerk.count', -1) do
      delete membership_clerk_url(@membership_clerk)
    end

    assert_redirected_to membership_clerks_url
  end
end

# require 'test_helper'
# 
# class UsersControllerTest < ActionDispatch::IntegrationTest
# 
#   def setup
#     @user       = users(:one)
#     @other_user = users(:two)
#   end
# 
#   test "should get index" do
#     log_in_as(@user)
#     get users_url
#     assert_response :success
#   end
# 
#   test "should get new" do
#     get new_subscription_member_path
#     assert_response :success
#   end
# 
#   test "should create user" do
#     assert_difference('User.count') do
#       post users_url, params: { user: { address_line_1: "3 High Street", 
#                                         address_line_2: nil, 
#                                         email: "user@readall.com", 
#                                         first_name: "Hugh", 
#                                         last_name: "Serr", 
#                                         password: "password12345", 
#                                         password_confirmation: "password12345",
#                                         post_code: "ED9 3TT", 
#                                         tel_no: "02934175847", 
#                                         town: "Edinburgh", 
#                                         type: "User" } }
#     end
# 
#     assert_redirected_to user_url(User.last)
#   end
# 
#   test "should show user" do
#     log_in_as(@user)
#     get user_url(@user)
#     assert_response :success
#   end
# 
#   test "should get edit" do
#     log_in_as(@user)
#     get edit_user_url(@user)
#     assert_response :success
#   end
# 
#   test "should update user" do
#     log_in_as(@user)
#     patch user_url(@user), params: { user: { address_line_1: @user.address_line_1, 
#                                              address_line_2: @user.address_line_2, 
#                                              email: @user.email, 
#                                              first_name: "UpdatedUser", 
#                                              last_name: @user.last_name, 
#                                              password: 'password123',
#                                              password_confirmation: 'password123',
#                                              post_code: @user.post_code, 
#                                              tel_no: @user.tel_no, 
#                                              town: @user.town, 
#                                              type: @user.type } }
#     assert_redirected_to user_url(@user)
#   end
# 
#   test "should destroy user" do
#     log_in_as(@user)
#     assert_difference('User.count', -1) do
#       delete user_url(@user)
#     end
# 
#     assert_redirected_to users_url
#   end
# 
#   test "should redirect edit when not logged in" do
#     get edit_user_path(@user)
#     assert_not flash.empty?
#     assert_redirected_to login_url
#   end
# 
#   test "should redirect update when not logged in" do
#     patch user_path(@user), params: { user: { first_name: @user.first_name,
#                                               email:      @user.email } }
#     assert_not flash.empty?
#     assert_redirected_to login_url
#   end
# 
#   test "should redirect edit when logged in as wrong user" do
#     log_in_as(@other_user)
#     get edit_user_path(@user)
#     assert flash.empty?
#     assert_redirected_to root_url
#   end
# 
#   test "should redirect update when logged in as wrong user" do
#     log_in_as(@other_user)
#     patch user_path(@user), params: { user: { first_name: @user.first_name,
#                                               email:      @user.email } }
#     assert flash.empty?
#     assert_redirected_to root_url
#   end
# end

# require 'test_helper'
# 
# class UsersSignupTest < ActionDispatch::IntegrationTest
# 
#   test "invalid signup information" do
#     get signup_path
#     assert_no_difference 'User.count' do
#       post users_path, params: { user: { first_name: "Stephan",
#                                          last_name:  "Horvath",
#                                          address_line_1: "1 Glasgow Street",
#                                          address_line_2: nil,
#                                          town: "Glasgow",
#                                          post_code: "G12 3HI",
#                                          tel_no: "0123456789",
#                                          email: "stephan_h@readall.com",
#                                          password: "password",
#                                          password_confirmation: "123456",
#                                          type: "User" } }
#     end
#     assert_template 'users/new'
#   end
# 
#   test "valid signup information" do
#     get signup_path
#     assert_difference 'User.count', 1 do
#       post users_path, params: { user: { first_name: "Stephan",
#                                          last_name:  "Horvath",
#                                          address_line_1: "1 Glasgow Street",
#                                          address_line_2: nil,
#                                          town: "Glasgow",
#                                          post_code: "G12 3HI",
#                                          tel_no: "0123456789",
#                                          email: "stephan_h@readall.com",
#                                          password: "password",
#                                          password_confirmation: "password",
#                                          type: "User" } }
#     end
#     follow_redirect!
#     assert_template 'users/show'
#     assert is_logged_in?
#   end
# 
# end

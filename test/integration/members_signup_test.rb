  # require 'test_helper'
  # 
  # class MembersSignupTest < ActionDispatch::IntegrationTest
  # 
  #   test "invalid signup information" do
  #     get subscribe_paperback2u_path(1)
  #     assert_no_difference 'Member.count' do
  #       post members_path, params: { member: { first_name: "Stephan",
  #                                             last_name:  "Horvath",
  #                                             address_line_1: "1 Glasgow Street",
  #                                             address_line_2: nil,
  #                                             town: "Glasgow",
  #                                             post_code: "G12 3HI",
  #                                             tel_no: "0123456789",
  #                                             email: "stephan_h@readall.com",
  #                                             password: "password",
  #                                             password_confirmation: "123456",
  #                                             plan_id: 1 } }
  #     end
  #     assert_template 'subscribe/paperback2u'
  #   end
  # 
  # test "valid signup information" do
  #   get subscribe_paperback2u_path
  #   assert_difference 'Member.count', 1 do
  #     post subscription_members_path, params: { member: { first_name: "Stephan",
  #                                                         last_name:  "Horvath",
  #                                                         address_line_1: "1 Glasgow Street",
  #                                                         address_line_2: nil,
  #                                                         town: "Glasgow",
  #                                                         post_code: "G12 3HI",
  #                                                         tel_no: "0123456789",
  #                                                         email: "stephan_h@readall.com",
  #                                                         password: "password",
  #                                                         password_confirmation: "password" } }
  #   end
  #   follow_redirect!
  #   assert_template 'members/show'
  #   # assert is_logged_in?
  # end

  # end

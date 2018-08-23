require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:member_one)
    plan_id = Plan.create(stripe_id: "Paperback 2", nickname: "Unlimited - Paperback 2",
                                  display_price: 800.0, product: "test_product").id
    @manager = managers(:manager_one)
  end

  test "should get index" do
    log_in_as(@manager)
    get members_path
    assert_response :success
  end

  test "should get new" do
    get subscribe_paperback2u_path
    assert_response :success
  end

  # test "should create member" do
  #   assert_difference('Member.count') do
  #     post members_path, params: { member: { address_line_1: "134 Circus Drive", 
  #                                           address_line_2: nil, 
  #                                           email: "david@readall.com", 
  #                                           first_name: "David", 
  #                                           last_name: "Memberberg", 
  #                                           password: "12233344445", 
  #                                           password_confirmation: "12233344445",
  #                                           post_code: "G22 9JJ", 
  #                                           tel_no: "07549284757", 
  #                                           town: "Glasgow",
  #                                           plan_id: 1 } }
  #   end
  #
  #   assert_redirected_to member_url(Member.last)
  # end

  test "should show member" do
    log_in_as(@member)
    get member_url(@member)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@member)
    get edit_member_url(@member)
    assert_response :success
  end

  test "should update member" do
    log_in_as(@member)
    @member.plan_id = 1
    patch member_url(@member), params: { member: { address_line_1: @member.address_line_1, 
                                                   address_line_2: @member.address_line_2, 
                                                   email: @member.email, 
                                                   first_name: @member.first_name, 
                                                   last_name: @member.last_name, 
                                                   password: "555554444333221", 
                                                   password_confirmation: "555554444333221",
                                                   post_code: @member.post_code, 
                                                   tel_no: @member.tel_no, 
                                                   town: @member.town,
                                                   plan_id: 1 } }
    assert_redirected_to member_url(@member)
  end

  # test "should destroy member" do
  #   log_in_as(@member)
  #   assert_difference('Member.count', -1) do
  #     delete member_url(@member)
  #   end

  #   assert_redirected_to members_url
  # end
end

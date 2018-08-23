require 'test_helper'

class ManagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manager = managers(:manager_one)
  end

  test "should get index" do
    get managers_url
    assert_response :success
  end

  test "should get new" do
    get new_manager_url
    assert_response :success
  end

  test "should create manager" do
    assert_difference('Manager.count') do
      post managers_url, params: { manager: { first_name: "Michael",
                                              last_name: "Manager",
                                              address_line_1: "2 Long Street",
                                              address_line_2: nil,
                                              town: "Glasgow",
                                              post_code: "G11 9JK",
                                              tel_no: "09878987",
                                              email: "michael@manager.com",
                                              password: "password123",
                                              password_confirmation: "password123",
                                              type: "Manager" } }
    end

    assert_redirected_to manager_url(Manager.last)
  end

  test "should show manager" do
    get manager_url(@manager)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@manager)
    get edit_manager_url(@manager)
    assert_response :success
  end

  test "should update manager" do
    log_in_as(@manager)
    patch manager_url(@manager), params: { manager: { first_name: @manager.first_name,
                                                      last_name: "New LastName",
                                                      address_line_1: @manager.address_line_1,
                                                      address_line_2: @manager.address_line_2,
                                                      town: @manager.town,
                                                      post_code: @manager.post_code,
                                                      tel_no: @manager.tel_no,
                                                      email: @manager.email,
                                                      password: "password",
                                                      password_confirmation: "password" } }
    assert_redirected_to manager_url(@manager)
  end

  test "should destroy manager" do
    log_in_as(@manager)
    assert_difference('Manager.count', -1) do
      delete manager_url(@manager)
    end

    assert_redirected_to managers_url
  end
end

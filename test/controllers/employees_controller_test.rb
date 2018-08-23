require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:employee_one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { first_name:      "Employee1", 
                                                last_name:       "Employee1",
                                                address_line_1:  "1 Emperor Street",
                                                address_line_2:  nil,
                                                town:            "Glasgow",
                                                post_code:       "G22 8TR",
                                                tel_no:          "93847484334",
                                                email:           "employee1@email.com",
                                                password: "password321",
                                                password_confirmation: "password321",
                                                type:            "Employee" } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { town: "Edinburgh",
                                                         password: "password123123123",
                                                         password_confirmation: "password123123123",
                                                         type: @employee.type } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end

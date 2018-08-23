require 'test_helper'

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:member_one)
    @manager = managers(:manager_one)
    @loan = loans(:one)
  end

  # test "should get index" do
  #   log_in_as(@manager)
  #   get loans_url
  #   assert_response :success
  # end

  test "should get new" do
    get new_loan_url
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post loans_url, params: { loan: { begin_date: @loan.begin_date,
                                        end_date: @loan.end_date,
                                        returned: @loan.returned,
                                        user: @loan.user } }
    end

    assert_redirected_to loan_url(Loan.last)
  end

  test "should show loan" do
    log_in_as(@member)
    get loan_url(@loan)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_url(@loan)
    assert_response :success
  end

  test "should update loan" do
    patch loan_url(@loan), params: { loan: { begin_date: @loan.begin_date,
                                             end_date: @loan.end_date, 
                                             returned: true,
                                             user: @loan.user } }
    assert_redirected_to loan_url(@loan)
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete loan_url(@loan)
    end

    assert_redirected_to loans_url
  end
end

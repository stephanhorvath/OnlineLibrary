require 'test_helper'

class BookingClerksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking_clerk = booking_clerks(:booking_clerk_one)
  end

  test "should get index" do
    get booking_clerks_url
    assert_response :success
  end

  test "should get new" do
    get new_booking_clerk_url
    assert_response :success
  end

  test "should create booking_clerk" do
    assert_difference('BookingClerk.count') do
      post booking_clerks_url, params: { booking_clerk: { address_line_1: "1 Clerk Street", 
                                                          address_line_2: nil, 
                                                          email: "clark@clerk.com", 
                                                          first_name: "Clark", 
                                                          last_name: "Clerk", 
                                                          password: "password123", 
                                                          password_confirmation: "password123",
                                                          post_code: "G29 3OP", 
                                                          tel_no: "04857332954", 
                                                          town: "Glasgow", 
                                                          type: "BookingClerk" } }
    end

    assert_redirected_to booking_clerk_url(BookingClerk.last)
  end

  test "should show booking_clerk" do
    get booking_clerk_url(@booking_clerk)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_clerk_url(@booking_clerk)
    assert_response :success
  end

  test "should update booking_clerk" do
    patch booking_clerk_url(@booking_clerk), params: { booking_clerk: { address_line_1: @booking_clerk.address_line_1, 
                                                                        address_line_2: @booking_clerk.address_line_2, 
                                                                        email: @booking_clerk.email, 
                                                                        first_name: @booking_clerk.first_name, 
                                                                        last_name: @booking_clerk.last_name, 
                                                                        password: "999password999", 
                                                                        password_confirmation: "999password999",
                                                                        post_code: @booking_clerk.post_code, 
                                                                        tel_no: @booking_clerk.tel_no, 
                                                                        town: @booking_clerk.town, 
                                                                        type: @booking_clerk.type } }
    assert_redirected_to booking_clerk_url(@booking_clerk)
  end

  test "should destroy booking_clerk" do
    assert_difference('BookingClerk.count', -1) do
      delete booking_clerk_url(@booking_clerk)
    end

    assert_redirected_to booking_clerks_url
  end
end

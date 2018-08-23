require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:book_one)
    @book.cover = File.new("public/assets/book1.png")
    @manager = managers(:manager_one)
    @member = members(:member_one)
  end

  test "should redirect index when not logged in" do
    get books_path
    assert_redirected_to login_url
  end

  # test "should get index" do
  #   log_in_as(@member)
  #   get books_path
  #   assert_response :success
  # end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    log_in_as(@manager)
    assert_difference('Book.count') do
      post books_url, params: { book: { author: @book.author,
                                        description: @book.description,
                                        genre: @book.genre,
                                        publisher: @book.publisher,
                                        supplier_id: @book.supplier_id,
                                        title: @book.title,
                                        type: @book.type } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    log_in_as(@manager)
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@manager)
    get edit_book_url(@book)
    assert_response :success
  end

  # test "should update book" do
  #   log_in_as(@manager)
  #   patch book_url(@book), params: { book: { author: @book.author,
  #                                            description: @book.description,
  #                                            genre: @book.genre,
  #                                            publisher: @book.publisher,
  #                                            supplier_id: @book.supplier_id,
  #                                            title: @book.title,
  #                                            type: @book.type } }
  #   assert_redirected_to book_url(@book)
  # end

  # test "should destroy book" do
  #   log_in_as(@manager)
  #   assert_difference('Book.count', -1) do
  #     delete book_url(@book)
  #   end

  #   assert_redirected_to books_url
  # end
end

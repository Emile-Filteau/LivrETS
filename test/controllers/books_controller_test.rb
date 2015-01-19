require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do

    assert_difference('Book.count') do
      course_string = courses(:one).id.to_s + ','+ courses(:two).id.to_s
      post :create, book: {courses: course_string, name: @book.name, state: @book.state, price: @book.price, contact_name: @book.contact_name, email: 'etsbook111@gmail.com' }
    end
    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book, code: @book.validation_code
    assert_response :success
  end

  test "should update book" do
    course_string = courses(:one).id.to_s + ','+ courses(:two).id.to_s
    patch :update, id: @book, code: @book.validation_code, book: {courses: course_string, author: @book.author, contact_name: @book.contact_name, email: @book.email, name: @book.name, state: @book.state}
        assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book, code: @book.validation_code
    end

    assert_redirected_to books_path
  end
end

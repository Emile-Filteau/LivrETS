require 'test_helper'

class CoursesControllerTest < ActionController::TestCase

  setup do
    @course = courses(:one)

    user = Rails.application.config.admin_user
    pw = Rails.application.config.admin_password
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  test "should get index" do
    courses(:one).program = programs(:one)
    courses(:two).program = programs(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    @program = programs(:one)
    assert_difference('Course.count') do
      post :create, course: { acronym: @course.acronym, name: @course.name, program_id: programs(:one).id }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    @new_program = programs(:two)
    patch :update, id: @course, course: { name: 'TestCourse', acronym:'TST', program_id: @new_program.id }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end

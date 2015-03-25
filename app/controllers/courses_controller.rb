class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: Rails.application.config.admin_user, password: Rails.application.config.admin_password, except: [:index, :search, :show]

  # GET /courses
  def index
    @courses = Course.all
  end

  def search
    if not params[:q].nil? and  not params[:q].empty?
      @courses = Course.where('lower(acronym) like lower(?) OR lower(name) like lower(?)', "%#{params[:q]}%", "%#{params[:q]}%").map { |course| {id: course.id, name: course.acronym + ' - ' + course.name} }
    else
      @course = []
    end
    render json: @courses
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /courses/1
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:acronym, :name, :program)
  end
end

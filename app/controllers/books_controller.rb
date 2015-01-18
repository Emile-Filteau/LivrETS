class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :activate, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.where(activated: true).order(created_at: :desc)
  end

  # GET /books/search
  def search
    if params[:search].to_s != ''
      course = Course.where("acronym = ?", params[:search]).first()
      if course
        # If it is a search by course (1 course only), and that course is found, return its books.
        @books = course.books.order(created_at: :desc)
      else
        # Else, check for book names OR author names
        if params[:search].length >= 3
          query = '%' + params[:search] + '%'
          @books = Book.where('activated = 1 AND name like ? OR author like ?', query, query).order(created_at: :desc)
        end
      end
    else
      redirect_to root_path
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    if params[:code] != @book.validation_code
      redirect_to root_path
      return
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    params.require(:book).permit(:courses)['courses'].split(',') do |course_id|
      @book.courses << Course.find(course_id)
      print(course_id)
    end

    # Validation code
    charset = [('a'..'z'), ('0'..'9'), ('A'..'Z')].map { |i| i.to_a }.flatten
    validation_code = (0...50).map { charset[rand(charset.length)] }.join
    @book.validation_code = validation_code
    @book.activated = false

    respond_to do |format|
      if @book.save
        UserMailer.information_email(@book).deliver!
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if params[:code] != @book.validation_code
      redirect_to root_path
      return
    end

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if params[:code] != @book.validation_code
      redirect_to root_path
      return
    end

    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /books/1/activate
  def activate
    if params[:code] != @book.validation_code
      redirect_to root_path
      return
    end

    @book.activated = true
    @book.save
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Book was successfully activated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :author, :edition, :state, :email, :contact_name, :contact_phone, :photo, :price)
    end
end

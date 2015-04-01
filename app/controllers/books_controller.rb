#encoding=utf-8
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :activate, :destroy, :contact]
  before_action :check_validation_code, only: [:edit, :update, :destroy, :activate]

  # GET /books
  # GET /books.json
  def index
    @books = Book.where(activated: true).order(created_at: :desc)
  end

  # GET /books/search
  def search
    return if params[:q].nil? or params[:q].empty?
    @search_term = params[:q]
    books = Array.new

    program = Program.find_by_acronym params[:q].upcase
    if program
      program.courses.each do |course|
        (books << course.books.order(created_at: :desc)).flatten!
      end
    end

    course = Course.find_by_acronym params[:q].upcase
    if course
      (books << course.books.order(created_at: :desc)).flatten!
    else
      (books << Book.where('lower(name) like ? OR lower(author) like ?', "%#{params[:q].downcase}%", "%#{params[:q].downcase}%").where(activated: true).order(created_at: :desc)).flatten!
    end
    @books = books
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
    respond_to do |format|
      format.html { render :edit, location: @book}
      format.json { render :show, location: @book}
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    params[:book][:courses].split(',').each do |course_id|
      @book.courses << Course.find(course_id)
    end

    # Validation code
    charset = [('a'..'z'), ('0'..'9'), ('A'..'Z')].map { |i| i.to_a }.flatten
    validation_code = (0...50).map { charset[rand(charset.length)] }.join
    @book.validation_code = validation_code
    @book.activated = false

    respond_to do |format|
      if @book.save
        UserMailer.information_email(@book).deliver!
        format.html { redirect_to @book, notice: 'Votre annonce a été crée, vérifier vos courriels.' }
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

    @book.courses = Array.new
    params[:book][:courses].split(',').each do |course_id|
      @book.courses << Course.find(course_id)
    end

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Votre annonce a été modifiée' }
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
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Votre annonce à été détruite !' }
      format.json { head :no_content }
    end
  end

  # GET /books/1/activate
  def activate
    @book.activated = true
    @book.save
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Votre annonce a été activée !' }
      format.json { render :show, status: :ok, location: @book }
    end
  end

  def contact
    infos = contact_params
    UserMailer.contact_email(@book, infos['name'], infos['email'], infos['message']).deliver!

    respond_to do |format|
      format.html { redirect_to @book, notice: 'Votre message a été envoyé' }
      format.json { render :show, status: :ok, location: @book }
    end
  end

  private

  def check_validation_code
    redirect_to root_path if params[:code] != @book.validation_code
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html {redirect_to :books, error: 'Cette annonce n\'existe pas !'}
      format.json {render json: {status: :error, text: 'Cette annonce n\'existe pas !'}}
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:name, :author, :edition, :state, :email, :contact_name, :contact_phone, :photo, :price)
  end

  def contact_params
    params.permit(:name, :email, :message)
  end
end

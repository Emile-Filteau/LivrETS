class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: Rails.application.config.admin_user, password: Rails.application.config.admin_password, except: [:index, :show]

  # GET /programs
  # GET /programs.json
  def index
    @programs = Program.all
  end

  # GET /programs/1
  def show
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs
  def create
    @program = Program.new(program_params)

    respond_to do |format|
      if @program.save
        format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /programs/1
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to programs_url, notice: 'Program was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_program
    @program = Program.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def program_params
    params.require(:program).permit(:acronym, :name, :color)
  end
end

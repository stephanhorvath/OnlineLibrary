##
# This class describes the actions for the Members Controller
class ManagersController < ApplicationController
  # Execute methods before actions in brackets
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :is_manager, only: [:index, :new, :create, :destroy]

  # GET /managers
  # GET /managers.json
  def index
    # Creates array of all managers in database
    @managers = Manager.all
  end

  # GET /managers/1
  # GET /managers/1.json
  def show
    # Finds manager in the database with id
    # passed on button press
    @manager = Manager.find(params[:id])
  end

  # GET /managers/new
  def new
    # Renders managers/new.html.erb
    # and creates new manager variable
    @manager = Manager.new
  end

  # GET /managers/1/edit
  def edit
    # Renders managers/edit.html.erb
    # and finds a manager in the database with the id
    # passed through button click.
    # Then it renders a partial managers/_form.html.erb
    @manager = Manager.find(params[:id])
  end

  # POST /managers
  # POST /managers.json
  def create
    # Create a new variable @manager
    # with the attributes filled out on
    # the form, passed to the create method
    # through the submit button, which triggers a POST action.
    @manager = Manager.new(manager_params)

    respond_to do |format|
      # Saves @member to the database
      # returns true if successful
      if @manager.save

        # log manager in
        log_in @manager

        # send success message and redirect to profile
        flash[:success] = "Welcome to ReadAll Library - Manager"
        format.html { redirect_to @manager } # notice: 'Manager was successfully created.' }
        format.json { render :show, status: :created, location: @manager }
      else
        # Render managers/new again.
        format.html { render :new }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /managers/1
  # PATCH/PUT /managers/1.json
  def update
    # Create new @manager variable
    # with Manager from database found id
    respond_to do |format|
      # find manager with passed parameter
      @manager = Manager.find(params[:id])

      # Update manager in database
      # return true if successful
      if @manager.update(manager_params)
        # send success message
        flash[:success] = "Profile Updated!"

        # redirect to manager profile
        format.html { redirect_to @manager }
        format.json { render :show, status: :ok, location: @manager }
      else
        # Render books/edit.html.erb again
        format.html { render :edit }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /managers/1
  # DELETE /managers/1.json
  def destroy
    # find manager that is being deleted and delete from database
    Manager.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Manager was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_manager
    @manager = Manager.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def manager_params
    params.require(:manager).permit(:first_name, :last_name, :address_line_1, :address_line_2, :town, :post_code, :tel_no, :email, :password, :password_confirmation)
  end

  # Uses SessionsHelper to determine
  # if a user is logged in.
  # If not they are redirected to login_url
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  # Verifies that the user attempting the action
  # is the manager that is signed in
  def correct_user
    @manager = Manager.find(params[:id])
    redirect_to(root_url) unless current_user?(@manager)
  end

  # Verifies that the user attempting the action
  # is a manager.
  def is_manager
    unless current_user.type == "Manager"
      flash[:danger] = "Access Denied - Insufficient Permissions"
      redirect_to root_url
    end
  end
end

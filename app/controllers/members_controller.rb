##
# This class describes the actions for the Members Controller
class MembersController < ApplicationController
  # Require Stripe gem
  require 'stripe'
  require 'date'

  # Before actions in brackets are executed, execute
  # each method
  before_action :is_manager,     only: [:index]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :has_no_loans,   only: [:destroy]

  # GET /members
  # GET /members.json
  def index
    # Creates array of all members in database
    @members = Member.all
    if params[:sort].in? %w[1 2 3]
      @members.merge!(Member.where(plan_id: params[:sort]))
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    # Finds member in the database with id
    # passed on button press
    @member = Member.find(params[:id])

    # variables to show the subscription begin and end date
    # formatted from unix epoch time
    @subscription = Stripe::Subscription.retrieve(@member.subscription_id)
    @sub_begin = DateTime.strptime(@subscription.current_period_start.to_s, '%s').strftime("%D")
    @sub_end = DateTime.strptime(@subscription.current_period_end.to_s, '%s').strftime("%D")
  end

  # GET /members/new
  def new
    # Renders members/new.html.erb
    # and creates new member variable
    @member = Member.new
    @plan_id ||= params[:plan_id]
    @member.plan_id = @plan_id
  end

  # GET /members/1/edit
  def edit
    # Renders members/edit.html.erb
    # and finds a member in the database with the id
    # passed through button click.
    # Then it renders a partial members/_form.html.erb
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    # Create a new variable @member
    # with the attributes filled out on
    # the form, passed to the create method
    # through the submit button, which triggers a POST action.
    @member = Member.new(member_params)
    @plan_id ||= @member.plan_id

    # assign plan_id passed from subscriptions/index to plan_id
    plan_id = params['member']['plan_id'].to_i

    respond_to do |format|
      if @member.save
        # Saves @member to the database
        # returns true if successful

        # Create a new Stripe Customer
        customer = Stripe::Customer.create({
          email: @member.email,
          source: params[:stripeToken]
        })

        # Assign Stipe's returned Customer ID
        # to @member's customer_id attribute
        @member.customer_id = customer.id

        # Assign plan_id passed through parameters
        # to @member.plan_id
        @member.plan_id = params['member']['plan_id'].to_i

        # Create a new Stripe Subscription
        subscription = Stripe::Subscription.create({
          customer: @member.customer_id,
          items: [{plan: Plan.find(params['member']['plan_id'].to_i).stripe_id}],
          billing: 'charge_automatically',
          # days_until_due: '7'
        })

        # Assign Stripe's returned Subscription ID
        # to @member's subscription_id attribute
        @member.subscription_id = subscription.id

        # Save @member to database
        @member.save

        # Log in member with SessionsHelper helper method
        log_in @member
        # Send welcome message to view.
        flash[:success] = 'Welcome to ReadAll Library!'
        format.html { redirect_to @member }
        format.json { render :show, status: :created, location: @member }
      # if @member.save is unsuccesful i.e. returns false
      else
        # Render members/new again.
        flash[:danger] = 'The following errors were found in your registration. '\
                         "#{@member.errors.full_messages}. "\
                         'Please try again.'
        format.html { redirect_to subscriptions_path }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    # Create new @member variable
    # with Member from database found id
    respond_to do |format|
      # find member with passed parameter
      @member = User.find(params[:id])

      # Updates @member in the database
      # returns true if successful
      if @member.update(member_params)
        # Send message to the view
        # and redirect to @member
        # which is shorthand for member_path(@member)
        # which is that member's show page.
        flash[:success] = 'Profile updated!'
        format.html { redirect_to @member }
        format.json { render :show, status: :ok, location: @member }
      # if @book.update returns false
      # which means there were errors
      else
        # Render books/edit.html.erb again
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    # Retrieves Stripe Customer ID from Stripe website
    # and deletes the member's subscription.
    customer = Stripe::Customer.retrieve(@member.customer_id)
    customer.subscriptions.retrieve(@member.subscription_id).delete

    # Deletes member from database.
    Member.find(params[:id]).destroy

    respond_to do |format|
      # Sends message to root view.
      flash[:success] = 'Account successfully deleted. Sad to see you go! :('
      format.html { redirect_to root_path } #, notice: 'Account successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:first_name,
                                   :last_name,
                                   :address_line_1,
                                   :address_line_2,
                                   :town,
                                   :post_code,
                                   :tel_no,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :type,
                                   :plan_id)
  end

  # Uses SessionsHelper to determine
  # if a user is logged in.
  # If not they are redirected to login_url
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Verifies that the user attempting the action
  # is the user that is signed in, or a manager.
  def correct_user
    @member = Member.find(params[:id])
    redirect_to(root_url) unless current_user?(@member) || current_user.type == 'Manager'
  end

  # Verifies that the user attempting the action
  # is a manager.
  def is_manager
    unless current_user.type == 'Manager'
      flash[:danger] = 'Access Denied - Insufficient Permissions'
      redirect_to root_url
    end
  end

  # Verifies that the user
  # does not have a loan before
  # attempting to delete their account.
  def has_no_loans
    # Get user from params
    @member = Member.find(params[:id])

    # Check associated loans array
    if @member.loans.any?
      # If they have any loans, iterate
      # through the array.
      @member.loans.each do |loan|
        # if any of the loans is not returned,
        # show error message and redirect to
        # their profile.
        if !loan.returned?
          flash[:danger] = 'You cannot delete an account if it has unreturned loans'
          redirect_to member_path(current_user.id)
        end
      end
    end
  end
end

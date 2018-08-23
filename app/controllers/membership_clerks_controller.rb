class MembershipClerksController < ApplicationController
  before_action :set_membership_clerk, only: [:show, :edit, :update, :destroy]

  # GET /membership_clerks
  # GET /membership_clerks.json
  def index
    @membership_clerks = MembershipClerk.all
  end

  # GET /membership_clerks/1
  # GET /membership_clerks/1.json
  def show
  end

  # GET /membership_clerks/new
  def new
    @membership_clerk = MembershipClerk.new
  end

  # GET /membership_clerks/1/edit
  def edit
  end

  # POST /membership_clerks
  # POST /membership_clerks.json
  def create
    @membership_clerk = MembershipClerk.new(membership_clerk_params)

    respond_to do |format|
      if @membership_clerk.save
        format.html { redirect_to @membership_clerk, notice: 'Membership clerk was successfully created.' }
        format.json { render :show, status: :created, location: @membership_clerk }
      else
        format.html { render :new }
        format.json { render json: @membership_clerk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /membership_clerks/1
  # PATCH/PUT /membership_clerks/1.json
  def update
    respond_to do |format|
      if @membership_clerk.update(membership_clerk_params)
        format.html { redirect_to @membership_clerk, notice: 'Membership clerk was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership_clerk }
      else
        format.html { render :edit }
        format.json { render json: @membership_clerk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /membership_clerks/1
  # DELETE /membership_clerks/1.json
  def destroy
    @membership_clerk.destroy
    respond_to do |format|
      format.html { redirect_to membership_clerks_url, notice: 'Membership clerk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership_clerk
      @membership_clerk = MembershipClerk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_clerk_params
      params.require(:membership_clerk).permit(:first_name, :last_name, :address_line_1, :address_line_2, :town, :post_code, :tel_no, :email, :password, :password_confirmation, :type)
    end
end

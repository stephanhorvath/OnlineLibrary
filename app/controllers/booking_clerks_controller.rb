class BookingClerksController < ApplicationController
  before_action :set_booking_clerk, only: [:show, :edit, :update, :destroy]

  # GET /booking_clerks
  # GET /booking_clerks.json
  def index
    @booking_clerks = BookingClerk.all
  end

  # GET /booking_clerks/1
  # GET /booking_clerks/1.json
  def show
  end

  # GET /booking_clerks/new
  def new
    @booking_clerk = BookingClerk.new
  end

  # GET /booking_clerks/1/edit
  def edit
  end

  # POST /booking_clerks
  # POST /booking_clerks.json
  def create
    @booking_clerk = BookingClerk.new(booking_clerk_params)

    respond_to do |format|
      if @booking_clerk.save
        format.html { redirect_to @booking_clerk, notice: 'Booking clerk was successfully created.' }
        format.json { render :show, status: :created, location: @booking_clerk }
      else
        format.html { render :new }
        format.json { render json: @booking_clerk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /booking_clerks/1
  # PATCH/PUT /booking_clerks/1.json
  def update
    respond_to do |format|
      if @booking_clerk.update(booking_clerk_params)
        format.html { redirect_to @booking_clerk, notice: 'Booking clerk was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking_clerk }
      else
        format.html { render :edit }
        format.json { render json: @booking_clerk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_clerks/1
  # DELETE /booking_clerks/1.json
  def destroy
    @booking_clerk.destroy
    respond_to do |format|
      format.html { redirect_to booking_clerks_url, notice: 'Booking clerk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking_clerk
      @booking_clerk = BookingClerk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_clerk_params
      params.require(:booking_clerk).permit(:first_name, :last_name, :address_line_1, :address_line_2, :town, :post_code, :tel_no, :email, :password, :password_confirmation, :type)
    end
end

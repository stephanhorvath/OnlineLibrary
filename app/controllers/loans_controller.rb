##
# This class describes the actions for the Loans Controller
class LoansController < ApplicationController
  # Executes method before each action between brackets.
  before_action :is_manager, only: [:index, :edit, :update]
  before_action :logged_in_user, only: [:new, :show, :destroy]
  before_action :correct_user, only: [:show, :destroy]
  before_action :book_limit, :not_empty, only: [:create]
  before_action :has_active_loan, only: [:create]

  # GET /loans
  # GET /loans.json
  def index
    # Creates an array of all the loans in the database
    @loans = Loan.all

    if params[:sort].in? %w[placed cancelled returned]
      @loans.merge!(Loan.where(status: params[:sort]))
    end

    # Returns a different view depending on the format send to the index method
    respond_to do |format|
      # If format sent is html, return index.html.erb
      format.html
      # If format sent is xlsx, return index.xlsx.axlsx
      format.xlsx {
        # Creates an attachment called "all_books_.xlsx" with that day's
        # date interpolated into the file name
        response.headers['Content-Disposition'] = "attachment; filename=all_loans_#{Date.today}.xlsx"
        # Sends a message to the view
        flash[:success] = "Exported loans list - file: all_loans_#{Date.today}.xlsx"
      }
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    # Finds a loan in the database with the id passed through
    # parameters, through the button that was clicked
    # and renders loans/show.html.erb
    @loan = Loan.find(params[:id])
  end

  # GET /loans/new
  def new
    # Creates an empty array
    @books = []

    # Iterates through each id in the session[:cart]
    # finds the book in the books table with the id
    # and inserts it into the @books array
    session[:cart].each do |book|
      @books << Book.find_by_id(book)
    end
    # Renders loans/new.html.erb
    # and creates a new loan variable
    # The view renders a partial loans/_form.html.erb
    # which has the form for creating a new loan.
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
    # Empty array
    @books = []

    # Finds loan through passed ID
    @loan = Loan.find(params[:id])

    # Creates array containing every loan line in that loan
    @loan_lines = @loan.loan_lines

    # Iterates through array
    @loan_lines.each do |line|
      # Inserts each line's book into @books array
      @books << Book.find_by_id(line.book_id)
    end
  end

  # POST /loans
  # POST /loans.json
  def create
    # Creates empty array if it doesn't exist
    # otherwise use existing array
    @books ||= []

    # Iterates through each id in array
    session[:cart].each do |book|
      # Finds books by ID and inserts into array
      @books << Book.find_by_id(book)
    end

    # Calculates number of books for loan
    lines = @books.size

    # Creates new loan to accept parameters
    @loan = Loan.new(loan_params)

    respond_to do |format|
      # if @loan is saved returns true
      if @loan.save
        # iterates through number of lines
        lines.times do |loan_line, iteration=0|
          # assigns newly created loan id
          loan_id = @loan.id

          # Assings last book from @books
          # to @book and removes it from array
          @book = @books.pop

          # Assings @book's ID
          book_id = @book.id

          # Creates new loan line with
          # passed loan_id and book_id
          LoanLine.create!(loan_id: loan_id,
                          book_id: book_id)
          iteration+=1
        end

        # Iterates through number of books
        # in @loan and decreases stock by 1
        @loan.books.each do |book|
          book.stock = book.stock - 1

          # Saves book so stock is saved
          book.save
        end

        # Change loan status to placed
        @loan.status = 'placed'
        # Save to retain changes
        @loan.save

        # Pass success message
        flash[:success] = 'Loan placed!'

        # Empty cart
        session[:cart] = []

        # Redirect to new loan's details
        format.html { redirect_to @loan }
        format.json { render :show, status: :created, location: @loan }
      # if new loan is invalid and cannot be saved
      else
        # Pass error message
        # Render form again
        flash[:danger] = 'Something went wrong'
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    # Create new @loan variable
    # with Loan from database found through
    # id passed to the action
    @loan = Loan.find(params[:id])

    respond_to do |format|
      # Updates @loan in the database
      # returns true if successful
      if @loan.update(loan_params)

        # set status as returned
        @loan.status = 'returned'

        # iterate through each book
        # and increase stock by 1
        @loan.books.each do |book|
          book.stock = book.stock + 1
          # save changes in database
          book.save
        end

        # save changes in database
        @loan.save

        # pass message to next view
        flash[:success] = 'Loan successfully marked as returned'
        format.html { redirect_to @loan }
        format.json { render :show, status: :ok, location: @loan }
      # if @loan.update cannot be updated
      else
        # re-render edit form
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    # Finds a member in the database with the id passed
    # through the loan that is being cancelled
    @member = Member.find(Loan.find(params[:id]).user_id)

    # Find loan that is being destroyed in database
    @loan = Loan.find(params[:id])

    # Set status
    @loan.status = "cancelled"

    # Set returned to true
    @loan.returned = true
    respond_to do |format|

      # if @loan is saved return true
      if @loan.save

        # iterate through each book in the loan
        # and increase stock by 1
        @loan.books.each do |book|
          book.stock = book.stock + 1
          # save changes in database
          book.save
        end

        # pass message to next view
        flash[:success] = "Loan successfully cancelled"
        # redirect to @loan's details page
        format.html { redirect_to loan_path(@loan) } #, notice: 'Loan was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def loan_params
    params.require(:loan).permit(:begin_date,
                                 :end_date,
                                 :returned,
                                 :user_id,
                                 :status,
                                 :loan_line => [:loan_id,
                                                :book_id])
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
    @member = User.find(current_user.id)
    redirect_to(root_url) unless current_user?(@member) || current_user.type == 'Manager'
  end

  # Verifies that the user attempting the action
  # is a manager.
  def is_manager
    if current_user.nil? || current_user.type != 'Manager'
      flash[:danger] = 'Access Denied - Insufficient Permissions'
      redirect_to root_url
    end
  end

  # limits number of books depending on member's subscription plan
  # passes the corresponding error message and refreshes page
  def book_limit
    if current_user.plan_id == 1 && session[:cart].size > 2
      flash[:danger] = 'Your subscription only allows 2 books to be checked out per loan.'
      redirect_to new_loan_path, limit: 1
    elsif current_user.plan_id == 2 && session[:cart].size > 4
      flash[:danger] = 'Your subscription only allows 4 books to be checked out per loan.'
      redirect_to new_loan_path, limit: 2
    elsif current_user.plan_id == 3 && session[:cart].size > 6
      flash[:danger] = 'Your subscription only allows 6 books to be checked out per loan.'
      redirect_to new_loan_path, limit: 3
    end
  end

  # Redirects back to book index if member tries to create a loan
  # with no books in cart. Passes warning message
  def not_empty
    if session[:cart].empty?
      flash[:danger] = 'Please add books to loan order before confirming.'
      redirect_to books_path
    end
  end

  # Redirects to books index if member has existing loan
  def has_active_loan
    # finds current member
    @member = User.find(current_user.id)

    # Finds all of that member's loans that are not returned
    # (should only be 1, but it's an array in case there are more)
    @active_loan = @member.loans.where(returned: false)

    if @active_loan.any?
      flash[:danger] = 'You cannot make another loan order '\
        'if you have unreturned loans.'
      redirect_to books_path
    end
  end

end

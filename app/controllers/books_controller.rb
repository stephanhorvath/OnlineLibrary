##
# This class describes the actions for the Books Controller
class BooksController < ApplicationController
  # Before methods index and show are started, execute method logged_in_user
  before_action :logged_in_user, only: [:index, :show]
  # Before methods edit, update and destroy are started, execute method
  # user_is_manager
  before_action :user_is_manager, only: [:edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    # Creates an array of all the books in the database
    # but restricts them to 12 books per page, and generates
    # each page
    @books = Book.paginate(page: params[:page], per_page: 12)

    # Returns a different view depending on the format send to the index method
    respond_to do |format|
      # If format sent is html, return index.html.erb
      format.html
      # If format sent is xlsx, return index.xlsx.axlsx
      format.xlsx {
        # Creates an array of all books without pagination
        @books = Book.all
        # Creates an attachment called "all_books_.xlsx" with that day's
        # date interpolated into the file name
        response.headers['Content-Disposition'] = 'attachment; '\
                                         "filename=all_books_#{Date.today}.xlsx"
        # Sends a message to the view
        flash[:success] = 'Exported book list - '\
                          "file: all_books_#{Date.today}.xlsx"
      }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    # Finds a book in the database with the id passed through
    # parameters, through the button that was clicked
    # and renders books/show.html.erb
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    # Renders books/new.html.erb
    # and creates a new book variable
    # The view renders a partial books/_form.html.erb
    # which has the form for creating a new book.
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    # Renders books/edit.html.erb
    # and finds a book in the database with the id passed through
    # parameters, through the button that was clicked.
    # Then it renders a partial books/_form.html.erb
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    # Create a new variable @book
    # with the attributes filled out on
    # the form, passed to the create method
    # through the submit button, which triggers a POST action.
    @book = Book.new(book_params)

    respond_to do |format|
      # Saves @book to the database
      # if retuns true if @book was saved
      if @book.save
        # Send message to the view
        # and redirect to @book
        # which is shorthand for book_path(@book)
        # which is that book's show page.
        flash[:success] = "Book #{@book.title.titleize} was added to the library!"
        format.html { redirect_to @book }
        format.json { render :show, status: :created, location: @book }
      # if @book.save returns false
      # which means there were errors
      else
        # Render books/new.html.erb again
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    # Create new @book variable
    # with Book from database found through
    # id passed to the action
    @book = Book.find(params[:id])

    respond_to do |format|
      # Updates @book in the database
      # returns true if successful
      if @book.update(book_params)
        # Send message to the view
        # and redirect to @book
        # which is shorthand for book_path(@book)
        # which is that book's show page.
        flash[:success] = "#{@book.title.titleize} details successfully updated."
        format.html { redirect_to @book }
        format.json { render :show, status: :ok, location: @book }
      # if @book.update returns false
      # which means there were errors
      else
        # Render books/edit.html.erb again
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    # Finds a book in the database with the id passed through
    # parameters, through the button that was clicked
    @book = Book.find(params[:id])

    # Deletes that book from the database
    @book.destroy
    respond_to do |format|
      # Sends message to redirected view - books/index.html.erb
      flash[:success] = 'Successfully deleted book from library.'
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  # PUT /add_to_cart.1
  def add_to_cart
    # Finds a book in the database with the id passed through
    # parameters, through the button that was clicked
    @book = Book.find(params[:format])

    # if session[:cart].nil?
    #   session[:cart] ||= []
    # end
    #
    # shorthand for method above
    # if session[:cart] exists, leave it
    # or if it does not, it is equal to an empty array
    session[:cart] ||= [] if session[:cart].nil?

    # Add @book's id (integer) to the session[:cart] array
    session[:cart] << @book.id
    session[:cart].uniq!

    # Send message to redirected view
    # index.html.erb
    flash[:success] = "#{@book.title.titleize} was added to the cart"
    redirect_to books_url
  end

  # PUT /remove_from_cart.1
  def remove_from_cart
    # Finds a book in the database with the id passed through
    # parameters, through the button that was clicked
    @book = Book.find(params[:format])

    # Remove @book's id from session[:cart] array
    session[:cart].delete(@book.id)

    # Send message to redirected bew
    # loans/new.html.erb
    flash[:success] = "#{@book.title.titleize} was removed from the cart"
    redirect_to new_loan_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def book_params
    params.require(:book).permit(:title,
                                 :author,
                                 :description,
                                 :genre,
                                 :publisher,
                                 :supplier_id,
                                 :stock,
                                 :type)
  end

  # Uses SessionsHelper to determine
  # if a user is logged in.
  # If not they are redirected to login_url
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please Log In'
      redirect_to login_url
    end
  end

  # Checks if a user is a manager.
  # If not, they are redirected and shown
  # an 'Access Denied!' message.
  def user_is_manager
    if !current_user.type == 'Manager'
      flash[:danger] = 'Access Denied'
      redirect_to books_path
    end
  end

end

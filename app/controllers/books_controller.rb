class BooksController < ApplicationController
  def borrow
    @book=Book.find(params[:id])
    Rails.logger = Logger.new(STDOUT)
    logger.debug "Book id passed is #{params[:id]}"
    logger.debug "Book returned by search #{@book.id}"
    @book.is_borrowed=true
    @book.user_id = current_user.id
    if @book.save!
      # redirect_to @book, notice: 'Book was successfully borrowed.'
      render :show, status: :ok, location: @book
    else
      render :show
      # render json: @book.errors, status: :unprocessable_entity
    end
    #create check_out_history of book #vicky
    create_request params[:id], current_user.id, Time.now.getlocal
  end

  def create_request(book_id, user_id, borrow_time)
    @request = Request.new
    @request.book_id = book_id
    @request.user_id = user_id
    @request.borrow_time = borrow_time
    @request.save!
  end

  def return
    @book=Book.find_by id: params[:id]
    @book.is_borrowed = false
    @book.user_id=nil
    @book.save
    @request = Request.find_by id: params[:request_id]
    @request.destroy

    @requests=@book.requests
    @requests.each do |request|
      if request.borrow_time < Time.zone.now
        @request.destroy
      end
    end

    redirect_to @book
  end

  def complete_request(book_id, user_id, return_time)
    @request = Request.find_by(:book_id => book_id, :user_id => user_id, :return_time => nil)
    @request.return_time = return_time
    @request.save!
  end

  def request_book
    @book=Book.find_by id: params[:id]

    @book.request.user_id=current_user.id
    if @book.save!
     render :show, status: :ok, location: @book
    else
    render :show
    render json: @book.errors, status: :unprocessable_entity
    end
  end

  def cancel_request
    @book=Book.find(params[:id])

    if @book.save!
     render :show, status: :ok, location: @book
    else
    render :show
    render json: @book.errors, status: :unprocessable_entity
    end
  end



  def index
    @books = Book.page(params[:page]).per Settings.users_per_page
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    @request = Request.new
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.save
    @categories = params[:categories]

    if !@categories.empty?
      @categories.each do |category|
        BooksCategory.create!(book_id: @book.id, category_id: @category.id)
      end
    end

  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])
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
    @book = Book.find(params[:id])
    respond_to do |format|
      if @book.present?
        @book.save
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

    # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :description, :author, :is_borrowed)
  end

end

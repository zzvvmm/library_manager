class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
    @data=params[:data]#params[:id]
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new
    @request.user_id=params[:user_id]
    @request.book_id=params[:book_id]
    format = "%d-%m-%Y %H:%M:%S"
    borrow_time = DateTime.strptime(params[:borrow_time], format)
    return_time = DateTime.strptime(params[:return_time], format)
    @request.borrow_time=borrow_time
    @request.return_time=return_time

    if @request.save!
      flash[:success] = t "flash_success"
    else
      flash[:warning] = t "flash_fail"
    end
    redirect_to book_path(params[:book_id])
  end


  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def request_cancel
    @request = Request.find_by user_id: params[:user_id], book_id: params[:book_id]
    if @request.destroy
      flash[:success] = t "flash_delete_success"
    else
      flash[:danger] = t "flash_delete_fail"
    end
    redirect_to book_path
  end

  def request_approve
    @request = Request.find_by user_id: params[:user_id], book_id: params[:book_id]
    @book = Book.find_by id: params[:book_id]
    @request.update_column :accepted, true
    @book.update_columns is_borrowed: true, user_id: params[:user_id]
    redirect_to @book
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Book history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find_by user_id: params[:user_id], book_id: params[:book_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:book_id, :user_id, :borrow_time, :return_time)
    end
end

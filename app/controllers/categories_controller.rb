class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.page(params[:page]).per Settings.categories_per_page
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @books = @category.books.page(params[:page]).per Settings.books_per_page
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t "flash_success"
      redirect_to categories_url
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash_update_success"
      redirect_to categories_url
    else
      render :edit
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if @category.destroy
      flash[:success] = t "flash_delete_success"
    else
      flash[:danger] = t "flash_delete_fail"
    end
    redirect_to categories_url
  end

    # Use callbacks to share common setup or constraints between actions.


  private

  def category_params
    params.require(:category).permit(:name, :description, :author)
  end

  def find_category
    @category = Category.find_by id: params[:id]
  end
end

class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: [:new, :create, :index]
  
  def index
    @categories = Category.order(created_at: :desc).paginate page: params[:page]
  end
  
  def show  
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Create Category Successfully"
      redirect_to admin_categories_url
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @category.update category_params
      flash[:success] = "Category updated"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end
  
  def destroy
    if @category.destroy
      flash[:success] = "Delete successfully"
    else
      flash[:danger] = "Cant Delete this Category"
    end
    redirect_to admin_categories_url
  end
    
  private
  def category_params
    params.require(:category).permit :name
  end
  
  def load_category
    @category = Category.find_by id: params[:id]
  end
end

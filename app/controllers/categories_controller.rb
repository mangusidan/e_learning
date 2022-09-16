class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  
  def index
    @categories = Category.order(:name).paginate page: params[:page]
  end
  
  def show
  end
end

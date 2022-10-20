class LessonsController < ApplicationController
  before_action :load_lesson, only: [:show, :update]
  before_action :logged_in_user, only: [:create, :update]
  
  def show
    @words = @lesson.category.words
    if @lesson.is_completed?
      flash[:success] = "Completed!"
    else
      flash[:success] = "Doing Lesson!"
    end
  end
  
  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.category.words.any?
      if @lesson.save
        flash[:success] = "Created successfully!"
        redirect_to @lesson
      else
        flash[:danger] = "Create Failed"
        redirect_to categories_url
      end
    else
      flash[:danger] = "Category has no word to create lesson"
      redirect_to categories_url
    end
  end
  
  def update
    if @lesson.update lesson_params
      @lesson.update_attribute(:is_completed, true)
      flash[:success] = "Successfully!"
      redirect_to @lesson
    else
      flash[:failed] = "Failed!!!"
    end
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    redirect_to categories_url if @lesson.nil?
  end
  
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      lesson_words_attributes: [:id, :word_id, :word_answer_id, :_destroy]
  end
end

class Admin::WordsController < Admin::BaseController
  before_action :load_category
  before_action :load_word, only: [:edit, :update, :destroy]
  
  def index
    @categories = Category.all
    word_type = params[:word_type] || Settings.all_word
    @words = Word.send(word_type, current_user)
     .by_category(params[:by_category])
     .order(:content)
     .paginate page: params[:page]
  end
    
  def new
    @word = @category.words.new
    @word.word_answers.new
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = "Add word successfully"
      redirect_to admin_category_url(@category)
    else
      flash[:danger] = "Failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update word_params
      flash[:success] = "Updated successfully"
      redirect_to admin_category_url(@category)
    else
      flash[:danger] = "Failed"
      render :edit
    end
  end

  def destroy
    Word.find_by(id: params[:id]).destroy
    redirect_to [:admin, @category]
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
  end

  def word_params
    params.require(:word).permit :content,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_word
    @word = Word.find_by id: params[:id]
  end
end

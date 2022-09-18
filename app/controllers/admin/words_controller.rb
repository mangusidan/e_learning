class Admin::WordsController < Admin::BaseController
  before_action :load_word, only: [:edit, :update, :destroy]
  
  def index
    @categories = Category.all
    word_type = params[:word_type] || Settings.all_word
    @words = Word.send(word_type, current_user)
     .by_category(params[:by_category])
     .order(:content)
     .paginate page: params[:page]
  end
  
  private  
  def word_params
    params.require(:word).permit :content  
  end
  
  def load_word
    @word = Word.find_by id: params[:id]  
  end
end

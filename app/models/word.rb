class Word < ApplicationRecord
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  scope :all_word, ->(user_id){}
  scope :learned, ->(user_id){joins(:lessons)
    .distinct.where(lessons: {is_completed: true, user_id: user_id})}
  scope :not_learned, ->(user_id){where.not id: Word.learned(user_id)}
  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end
  scope :content, -> { where(category: 'content') }

  validates :content, presence: true, uniqueness: true, length: { maximum: 255 }

  def answer
    self.word_answers.where(is_correct: true).first
  end

  def self.search(content)
    if content
      where('content LIKE ?', "%#{ content }%")
    else
      all
    end
  end
end


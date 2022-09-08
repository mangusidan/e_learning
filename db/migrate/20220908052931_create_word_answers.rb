class CreateWordAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :word_answers do |t|
      t.string :content
      t.integer :word_id
      t.boolean :is_correct

      t.timestamps
    end
  end
end

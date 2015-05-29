class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :upvotes
      t.integer :downvotes
      t.integer :user_id
      t.integer :question_id
      # t.string :create_time
      # t.string :udpate_time
      t.timestamps null: false
    end

    add_index :answers, "question_id"
    add_index :answers, "user_id"
  end
end

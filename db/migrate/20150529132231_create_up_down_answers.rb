class CreateUpDownAnswers < ActiveRecord::Migration
  def change
    create_table :up_down_answers do |t|
      t.integer :answer_id
      t.integer :user_id
      t.boolean :up
      t.boolean :down
      t.timestamps null: false
    end

    add_index :up_down_answers, ["answer_id","user_id"]
  end
end

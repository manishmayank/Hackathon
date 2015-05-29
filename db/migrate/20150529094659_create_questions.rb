class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :url
      t.string :parent_url
      t.text :content
      t.integer :upvotes
      t.integer :downvotes
      t.integer :user_id
      t.string :title
      # t.string :create_time
      # t.string :update_time
      t.integer :difference
      t.timestamps null: false
    end

    add_index :questions, ["user_id"]
  end
end

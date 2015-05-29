class CreateUpDowns < ActiveRecord::Migration
  def change
    create_table :up_downs do |t|
      t.integer :question_id
      t.integer :user_id
      t.boolean :up
      t.boolean :down
      t.timestamps null: false
    end

    add_index :up_downs, ["question_id","user_id"]
  end
end

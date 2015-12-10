class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :news_id
      t.string :owner_name
      t.string :comment_text

      t.timestamps null: false
    end
  end
end

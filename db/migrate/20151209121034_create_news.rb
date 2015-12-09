class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :user_id
      t.string :news_text
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end

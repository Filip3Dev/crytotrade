class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :media
      t.string :description
      t.string :category
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

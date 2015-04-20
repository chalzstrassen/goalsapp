class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :body
      t.integer :user_id, null: false
      t.string :privacy, default: 'public'

      t.timestamps
    end
  end
end

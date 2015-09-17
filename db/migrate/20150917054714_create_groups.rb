class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.integer :limitation

      t.timestamps null: false
    end
  end
end

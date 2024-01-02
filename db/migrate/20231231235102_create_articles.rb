class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :slug, null: false, unique: true
      t.string :title, null: false, unique: true
      t.text :description
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :articles, [:user_id, :created_at]
  end
end

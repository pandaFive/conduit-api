class AddIndexArticlesSlug < ActiveRecord::Migration[7.0]
  def change
    add_index :articles, :slug, unique: true
    add_index :articles, :title, unique: true
  end
end

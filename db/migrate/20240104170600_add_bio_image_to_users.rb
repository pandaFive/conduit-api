class AddBioImageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :string, default: ""
    add_column :users, :image, :string
  end
end

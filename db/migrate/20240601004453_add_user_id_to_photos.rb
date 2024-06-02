class AddUserIdToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :user_id, :integer
  end
end

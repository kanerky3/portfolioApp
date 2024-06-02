class AddPhotoContent < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :content, :string
  end
end

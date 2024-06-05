class User < ApplicationRecord
  # Gem bcrypt
  has_secure_password
  # name nilなし 上限100
  validates :name, presence: true, length: { maximum: 100 }
  # email nilなし ユニーク
  validates :email, presence: true, uniqueness: true
  
  def photos
    return Photo.where(user_id: self.id)
  end
end

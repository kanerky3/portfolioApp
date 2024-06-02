class Photo < ApplicationRecord
    validates :user_id, {presence: true}
    validates :image_name, {presence: true}
    validates :content, length:{maximum: 200}

    # 投稿からユーザー情報を出力
    def user
        return User.find_by(id: self.user_id)
    end
end

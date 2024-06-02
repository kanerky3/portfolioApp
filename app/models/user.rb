class User < ApplicationRecord
    # name nilなし 上限100
    validates :name, presence: true, length: { maximum: 100 }
    # email nilなし ユニーク
    validates :email, presence: true, uniqueness: true
    
end

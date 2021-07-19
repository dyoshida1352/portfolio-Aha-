class Post < ApplicationRecord

  belongs_to :user

  #画像用の設定
  attachment :post_image

  #バリデーション
  validates :post_name, :post_description,  presence: true

end

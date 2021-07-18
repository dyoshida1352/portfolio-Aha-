class Post < ApplicationRecord

  belongs_to :user

  #画像用の設定
  attachment :post_image

end

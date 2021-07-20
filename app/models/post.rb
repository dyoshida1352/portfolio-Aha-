class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy

  #画像用の設定
  attachment :post_image

  #バリデーション
  validates :post_name, :post_description,  presence: true

end

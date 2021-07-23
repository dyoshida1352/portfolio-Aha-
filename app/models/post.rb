class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  #いいね機能用のメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  #画像用の設定
  attachment :post_image

  #バリデーション
  validates :post_name, :post_description,  presence: true

end

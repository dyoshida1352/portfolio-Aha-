class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :invite_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #画像用の設定
  attachment :user_image

  #新規登録時の年代選択
  enum age: {"--未選択--": 0,"10代": 1,"20代": 2,"30代": 3,"40代": 4,"50代": 5,"60代以上": 6}

  #バリデーション
  validates :name, :age,  presence: true
end

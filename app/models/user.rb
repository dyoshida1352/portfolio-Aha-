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

  #フォロー機能
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed

  #フォロー機能のメソッド
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end


  #画像用の設定
  attachment :user_image

  #新規登録時の年代選択
  enum age: {"--未選択--": 0,"10代": 1,"20代": 2,"30代": 3,"40代": 4,"50代": 5,"60代以上": 6}

  #バリデーション
  validates :name, :age,  presence: true

end

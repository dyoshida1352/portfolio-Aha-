class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships

  #いいね機能用のメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  #タグ付け機能(投稿時)用のメソッド
  def save_tags(savepost_tags)
    savepost_tags.each do |new_tag_name|
      post_tag = Tag.find_or_create_by(tag_name: new_tag_name)
      self.tags << post_tag
    end
  end

  #タグ付け機能(編集時)用のメソッド
  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_tag_name|
      self.tags.delete Tag.find_by(tag_name: old_tag_name)
    end

    new_tags.each do |new_tag_name|
      post_tag = Tag.find_or_create_by(tag_name: new_tag_name)
      self.tags << post_tag
    end
  end


  #画像用の設定
  attachment :post_image

  #バリデーション
  validates :post_name, :post_description,  presence: true

end

class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  #画像用の設定
  attachment :post_image

  #いいね機能用のメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  #タグ機能用のメソッド
  def save_tags(tag_list)
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(tag_name: tag.downcase)
        begin
          self.tags.create!(tag_name: tag)
        rescue
          nil
        end
      else
        TagMap.create!(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end

  #バリデーション
  validates :post_name, :post_description,  presence: true

end

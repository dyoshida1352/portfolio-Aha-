class Tag < ApplicationRecord

  has_many   :tag_relationships, dependent: :destroy
  has_many   :posts, through: :tag_relationships

  #バリデーション
  validates :tag_name, uniqueness: true

end

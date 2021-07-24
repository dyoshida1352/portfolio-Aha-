class Tag < ApplicationRecord

  has_many :tag_maps, dependent: :destroy
  has_many :posts, through: :tag_maps

  #バリデーション
  validates :tag_name, presence: true, uniqueness: true, length: { maximum: 50 }

  private

    # タグ名を小文字に変換
    def downcase_tag_name
      self.tag_name.downcase!
    end

end

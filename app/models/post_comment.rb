class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  #バリデーション
  validates :post_comment, presence: true

end

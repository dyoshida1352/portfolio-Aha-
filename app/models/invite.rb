class Invite < ApplicationRecord

  belongs_to :user

  #画像用の設定
  attachment :invite_image

  #バリデーション
  validates :invite_name, :invite_description,  presence: true

end

class InviteComment < ApplicationRecord

  belongs_to :user
  belongs_to :invite

  #バリデーション
  validates :invite_comment, presence: true

end

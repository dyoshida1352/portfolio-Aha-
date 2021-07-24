class InviteTag < ApplicationRecord

  has_many   :invite_tag_relationships, dependent: :destroy
  has_many   :invites, through: :invite_tag_relationships

  #バリデーション
  validates :invite_tag_name, uniqueness: true

end

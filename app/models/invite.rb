class Invite < ApplicationRecord

  belongs_to :user
  has_many :invite_comments, dependent: :destroy
  has_many  :invite_tag_relationships, dependent: :destroy
  has_many  :invite_tags, through: :invite_tag_relationships

  #タグ付け機能(投稿時)用のメソッド
  def save_invite_tags(saveinvite_tags)
    saveinvite_tags.each do |new_invite_tag_name|
      invite_tag = InviteTag.find_or_create_by(invite_tag_name: new_invite_tag_name)
      self.invite_tags << invite_tag
    end
  end

  #タグ付け機能(編集時/編集後の保存時)用のメソッド
  def invite_tag_names
    invite_tags.pluck(:invite_tag_name)
  end

  def join_invite_tag_names(separator = ',')
    invite_tag_names.join(separator)
  end

  #タグ付け機能(編集後の保存時)用のメソッド
  def save_invite_tags(saveinvite_tags)
    current_invite_tags = self.invite_tags.pluck(:invite_tag_name) unless self.invite_tags.nil?
    old_invite_tags = current_invite_tags - saveinvite_tags
    new_invite_tags = saveinvite_tags - current_invite_tags

    old_invite_tags.each do |old_invite_tag_name|
      self.invite_tags.delete InviteTag.find_by(invite_tag_name: old_invite_tag_name)
    end

    new_invite_tags.each do |new_invite_tag_name|
      invite_tag = InviteTag.find_or_create_by(invite_tag_name: new_invite_tag_name)
      self.invite_tags << invite_tag
    end
  end




  #画像用の設定
  attachment :invite_image

  #バリデーション
  validates :invite_name, :invite_description,  presence: true

end

class InviteTagRelationship < ApplicationRecord

  belongs_to :invite
  belongs_to :invite_tag

end

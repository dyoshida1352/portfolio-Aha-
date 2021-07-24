class RemoveInviteFromTagRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tag_relationships, :invite, foreign_key: true
  end
end

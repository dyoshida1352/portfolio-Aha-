class CreateInviteTagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_tag_relationships do |t|

      t.references :invite, foreign_key: true
      t.references :invite_tag, foreign_key: true

      t.timestamps
    end
      add_index :invite_tag_relationships, [:invite_id, :invite_tag_id], unique: true
  end
end

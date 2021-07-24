class CreateTagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_relationships do |t|

      t.references :post, foreign_key: true
      t.references :invite, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
      add_index :tag_relationships, [:post_id, :invite_id, :tag_id],unique: true
  end
end

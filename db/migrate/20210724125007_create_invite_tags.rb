class CreateInviteTags < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_tags do |t|

      t.string :invite_tag_name

      t.timestamps
    end
  end
end

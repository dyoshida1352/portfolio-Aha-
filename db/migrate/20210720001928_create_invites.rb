class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.string :invite_name
      t.text :invite_description
      t.string :invite_image_id

      t.timestamps
    end
  end
end

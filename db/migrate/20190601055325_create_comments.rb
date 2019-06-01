class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.bigint :commenter_id
      t.string :commenter_type
      t.bigint :article_id
      t.bigint :entry_id
      t.string :type, null: false
      t.string :body, null: false

      t.timestamps

    end

    add_index :comments, :commenter_id
    add_index :comments, :commenter_type
    add_index :comments, :article_id
    add_index :comments, :entry_id
  end
end

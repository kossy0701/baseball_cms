class CreateEntryImages < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_images do |t|
      t.references :entry, null: false
      t.string :alt_text, null: false, default: ''
      t.integer :position

      t.timestamps
    end
  end
end

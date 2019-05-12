class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.integer :number
      t.string :name
      t.string :full_name
      t.string :email
      t.date :birthday
      t.integer :sex
      t.boolean :administrator

      t.timestamps
    end
  end
end

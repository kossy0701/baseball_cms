class AddPrefectureIdToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :prefecture_id, :integer, null: false
  end
end

class AddPerformedIdToActivityLog < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_logs, :performed_title, :string
    add_index :activity_logs, :performed_title
  end
end

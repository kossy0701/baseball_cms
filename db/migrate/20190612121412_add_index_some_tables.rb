class AddIndexSomeTables < ActiveRecord::Migration[5.2]
  def change
    add_index :members, :name
    add_index :members, :full_name
    add_index :articles, :title
    add_index :articles, :released_at
    add_index :entries, :title
    add_index :entries, :status
    add_index :entry_images, :position
    add_index :activity_logs, :log_type
    add_index :activity_logs, :performer_type
    add_index :activity_logs, :performer_id
    add_index :activity_logs, :performed_at
    add_index :comments, :type
  end
end

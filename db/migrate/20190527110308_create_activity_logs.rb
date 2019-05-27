class CreateActivityLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_logs do |t|
      t.integer :log_type, null: false
      t.string :performer_type, null: false
      t.bigint :performer_id, null: false
      t.datetime :performed_at, null: false

      t.timestamps
    end
  end
end

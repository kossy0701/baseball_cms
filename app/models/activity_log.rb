class ActivityLog < ApplicationRecord
  LOG_TYPE_VALUES = %w[login logout member_csv log_csv create_entry remove_entry create_article remove_article].freeze

  belongs_to :performer, polymorphic: true

  enum log_type: %i[login logout member_csv log_csv create_entry remove_entry create_article remove_article]

  validates :performer, presence: true
  validates :log_type, presence: true, inclusion: { in: LOG_TYPE_VALUES }
  validates :performed_at, presence: true

  def self.generate_csv
    data = %w[ユーザー名 日時 ログ]
    CSV.generate(headers: true) do |csv|
      csv << data
      all.includes(:performer).decorate.each do |log|
        csv << [
          log.performer.full_name,
          log.performed_date,
          log.log_type_view
        ]
      end
    end
  end
end

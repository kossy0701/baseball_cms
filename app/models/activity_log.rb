require 'csv'

class ActivityLog < ApplicationRecord

  belongs_to :performer, polymorphic: true

  enum log_type: [:login, :logout]

  validates :log_type, presence: true, inclusion: { in: ['login', 'logout'] }
  validates :performed_at, presence: true

  def self.generate_csv
    data = ['ユーザー名', '日時', 'ログ']
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

require 'csv'

class ActivityLog < ApplicationRecord

  belongs_to :performer, polymorphic: true

  enum log_type: [:login, :logout, :member_csv, :log_csv]

  validates :performer, presence: true
  validates :log_type, presence: true, inclusion: { in: ['login', 'logout', 'member_csv', 'log_csv'] }
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

class ActivityLog < ApplicationRecord

  belongs_to :performer, polymorphic: true

  enum log_type: [:login, :logout]

  validates :log_type, presence: true, inclusion: { in: ['login', 'logout'] }
  validates :performed_at, presence: true

end

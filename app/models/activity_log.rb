class ActivityLog < ApplicationRecord

  belongs_to :performer, polymorphic: true

  enum log_type: [:login, :logout]

end

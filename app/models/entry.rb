class Entry < ApplicationRecord
  STATUS_VALUES = ['draft', 'member_only', 'public']

  belongs_to :author, class_name: 'Member', foreign_key: 'member_id'
  has_many :images, class_name: 'EntryImage'

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: 'public') }
  scope :published, -> { where('status <> ?', 'draft') }
  scope :full, -> (member) { where('status <> ? OR member_id = ?', 'draft', member.id) }
  scope :readable_for, -> (member) { member ? full(member) : common }

end

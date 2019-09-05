class Entry < ApplicationRecord
  STATUS_VALUES = %w[draft member_only public].freeze

  belongs_to :author, class_name: 'Member', foreign_key: 'member_id'
  has_many :images, class_name: 'EntryImage'
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member
  has_many :entry_comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: 'public') }
  scope :published, -> { where('status <> ?', 'draft') }
  scope :full, ->(member) { where('status <> ? OR member_id = ?', 'draft', member.id) }
  scope :readable_for, ->(member) { member ? full(member) : common }
end

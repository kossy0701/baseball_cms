require 'csv'

class Member < ApplicationRecord

  attr_accessor :current_password

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :entries, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_many :activity_logs, as: :performer, dependent: :destroy
  has_many :comments, as: :commenter, dependent: :destroy

  has_one_attached :profile_picture

  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  has_secure_password

  enum sex: { male: 1, female: 2 }

  validates :number, presence: true,
    uniqueness: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than: 100,
      allow_blank: true
    }
  validates :name, presence: true,
    format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true },
    length: { minimum: 2, maximum: 20, allow_blank: true }
  validates :full_name, presence: true, length: { maximum: 20 }
  validates :sex, presence: true, inclusion: { in: ['male', 'female'] }
  validates :email, email: { allow_blank: true }
  validates :password, presence: { if: :current_password }

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      self.profile_picture.purge
    end
  end

  validate if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end
  end

  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end

  def self.generate_csv
    data = ['背番号', 'ユーザー名', '氏名', 'メールアドレス', '誕生日', '性別', '出身地']
    CSV.generate(headers: true) do |csv|
      csv << data
      all.decorate.each do |member|
        csv << [
          member.number,
          member.name,
          member.full_name,
          member.email,
          member.birthday,
          member.show_sex,
          member.prefecture.name
        ]
      end
    end
  end

end

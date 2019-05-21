class Member < ApplicationRecord

  attr_accessor :current_password

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :entries, dependent: :destroy

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
    length: { minimun: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false } # 大文字小文字を区別しない
  validates :full_name, presence: true, length: { maximum: 20 }
  validates :sex, presence: true, inclusion: { in: ['male', 'female'] }
  validates :email, email: { allow_blank: true }
  validates :password, presence: { if: :current_password }

end

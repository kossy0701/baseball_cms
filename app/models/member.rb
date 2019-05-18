class Member < ApplicationRecord


  has_secure_password

  validates :number, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      less_than: 100,
      allow_blank: true
    },
    uniqueness: true
  validates :name, presence: true,
    format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true },
    length: { minimun: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false } # 大文字小文字を区別しない
  validates :full_name, presence: true, length: { maximum: 20 }
  validates :email, email: { allow_blank: true }

  attr_accessor :current_password
  validates :password, presence: { if: :current_password }

end

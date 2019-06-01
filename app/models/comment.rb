class Comment < ApplicationRecord

  belongs_to :commenter, polymorphic: true
  belongs_to :article, optional: true
  belongs_to :entry, optional: true

  validates :body, presence: true
end

class Comment < ApplicationRecord
  belongs_to :commenter, polymorphic: true
  belongs_to :article, optional: true
  belongs_to :entry, optional: true

  validates :body, presence: true

  def commented_date
    created_at.strftime('%Y/%m/%d %H:%M')
  end
end

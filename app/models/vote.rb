class Vote < ApplicationRecord
  belongs_to :entry
  belongs_to :member

  validate do
    errors.add(:base, :invalid) unless member&.votable_for?(entry)
  end
end

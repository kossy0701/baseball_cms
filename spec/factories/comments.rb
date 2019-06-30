FactoryBot.define do
  factory :comment do
    body { Faker::Book.title }
    # commenter
    # article
    # entry
  end
end

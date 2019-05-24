FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Lorem.sentences }
    released_at { (Date.today - 1) }
    expired_at { (Date.today + 1) }
    member_only { [true, false].sample }
  end
end

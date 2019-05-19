FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Lorem.sentences }
    released_at { Date.today }
    member_only { [true, false].sample }
  end
end

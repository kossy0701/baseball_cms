FactoryBot.define do
  factory :entry do
    title { Faker::Book.title }
    body { Faker::Lorem.sentences }
    posted_at { (Date.today - 1) }
    status { "draft" }
    # member_id, null: false
  end
end

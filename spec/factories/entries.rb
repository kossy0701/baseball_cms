FactoryBot.define do
  factory :entry do
    title { Faker::Book.title }
    body { Faker::Lorem.sentences }
    posted_at { (Date.today - 1) }
    status { ['draft', 'member_only', 'public'].sample }
    # member_id, null: false
  end
end

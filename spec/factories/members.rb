FactoryBot.define do
  s1 = Date.parse("1960/01/01")
  s2 = Date.parse("1999/12/31")
  password = Faker::Internet.password(8)
  factory :member do
    number { rand(10..50) }
    name { ['Taro', 'Joe', 'Tom', 'Hana', 'Smith', 'Carry', 'Pasta', 'Burg', 'Shoe', 'Kiith'].sample }
    full_name { Faker::Japanese::Name.name }
    email { Faker::Internet.email }
    birthday { Random.rand(s1..s2) }
    sex { ['male', 'female'].sample }
    prefecture_id { rand(1..47) }
    administrator { false }
    password { password }
    password_confirmation { password }
  end
end

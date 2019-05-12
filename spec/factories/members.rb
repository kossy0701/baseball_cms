FactoryBot.define do
  factory :member do
    number { 1 }
    name { "MyString" }
    full_name { "MyString" }
    email { "MyString" }
    birthday { "2019-05-12" }
    sex { 1 }
    administrator { false }
  end
end

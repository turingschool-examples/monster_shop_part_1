FactoryBot.define do
  factory :random_user, class: User do
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    email { "MyString" }
    password { "MyString" }
  end
end

FactoryBot.define do
    factory :user do
      name { "John" }
      sequence(:email) { |n| "testing#{n}@gmail.com"  }
      password { "John123!" }
      password_confirmation { "John123!" }
    end
end
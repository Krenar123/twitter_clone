FactoryBot.define do
    factory :tweet do
      tweet { "This is test!" }
      user
    end
end
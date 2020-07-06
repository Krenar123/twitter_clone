FactoryBot.define do
  factory :retweet do
    rtweet {'This is just for testing!'}
    user
    tweet
  end
end

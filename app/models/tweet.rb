class Tweet < ApplicationRecord
    has_many :retweets
    validates :tweet, length: { in: 8..50 }
end

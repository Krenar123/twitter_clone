class Tweet < ApplicationRecord
    has_many :retweets, dependent: :destroy
    validates :tweet, length: { in: 8..50 }
end

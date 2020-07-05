class Tweet < ApplicationRecord
    has_many :retweets, dependent: :destroy
    belongs_to :user
    validates :tweet, length: { in: 8..50 }
end

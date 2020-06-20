class Retweet < ApplicationRecord
  belongs_to :tweet
  validates :rtweet, presence: true
end

class Tweet < ApplicationRecord
    validates :tweet, length: { in: 8..50 }
end

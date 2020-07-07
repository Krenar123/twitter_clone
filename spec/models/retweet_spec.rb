require 'rails_helper'

RSpec.describe Retweet do
    describe 'validations' do
        context 'presence' do
          it { should validate_presence_of(:rtweet)}
        end
    
        context 'length' do
          it { should validate_length_of(:rtweet).is_at_least(Retweet::MIN_RTWEET_LENGTH).is_at_most(Retweet::MAX_RTWEET_LENGTH)}
        end
    end
    
    describe 'authentications' do
        it { should belong_to(:tweet) }
        it { should belong_to(:user) }
    end
end

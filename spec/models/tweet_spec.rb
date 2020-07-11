require 'rails_helper'

RSpec.describe Tweet do
    describe 'validations' do
        context 'presence' do
          it { should validate_presence_of(:tweet)}
        end
    
        context 'length' do
          it { should validate_length_of(:tweet).is_at_least(Tweet::MIN_TWEET_LENGTH).is_at_most(Tweet::MAX_TWEET_LENGTH)}
        end
    end
    
    describe 'authentications' do
        it { should have_many(:retweets) }
        it { should have_many(:likes) }
        it { should belong_to(:user) }
    
        context 'dependecies' do
           context 'when destroying' do 
                let(:tweet) { create(:tweet) }
                it 'should destroy all retweets' do
                    create_list(:retweet, 1, tweet: tweet)
                    expect{tweet.destroy}.to change{Retweet.count}.by(-1)
                end
                
                it 'should destroy all likes' do
                    user = create(:user)
                    create_list(:like, 1, user: user,tweet: tweet)
                    expect{tweet.destroy}.to change{Like.count}.by(-1)
                end
            end  
        end
    end
end

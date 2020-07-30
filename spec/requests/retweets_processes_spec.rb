require 'rails_helper'

RSpec.describe "RetweetsProcesses" do
  describe "As not logged in user" do
    let(:tweet) { create(:tweet) }

    it 'cannot create retweets' do
      post_params = {
        params: {
          retweet: {
            rtweet: 'Just testing'
          }
        }
      }

      post tweet_retweets_path(tweet), post_params

      expect(response).to redirect_to(auths_login_path)
      follow_redirect!
      expect(flash[:danger]).to eq('Not logged in!')
    end

    it 'cannot update retweets' do
      retweet = create(:retweet,tweet: tweet)

      patch_params = {
        params: {
          retweet: {
            rtweet: 'Just testing'
          }
        }
      }
      patch tweet_retweet_path(tweet, retweet), patch_params
      
      expect(response).to redirect_to(auths_login_path)
      follow_redirect!
      expect(flash[:danger]).to eq('Not logged in!')
    end

    it 'cannot delete retweets' do
      retweet = create(:retweet, tweet: tweet)

      delete tweet_retweet_path(tweet, retweet)

      expect(response).to redirect_to(auths_login_path)
      follow_redirect!
      expect(flash[:danger]).to eq('Not logged in!')
    end
  end

  describe 'As logged in user' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user: user) }
    let(:other_user) { create(:user) }

    context 'when trying to manipulate with other users retweet' do

      before do 
        log_in_request(other_user)
      end

      it 'should not be able to update them' do
        retweet = create(:retweet, tweet: tweet)
        
        patch_params = {
          params: {
            retweet: {
              rtweet: 'Just testing'
            }
          }
        }
        patch tweet_retweet_path(tweet, retweet), patch_params
        
        expect(response).to redirect_to(tweet)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end
      
      it 'should not be able to destroy them' do
        retweet = create(:retweet, tweet: tweet)

        delete tweet_retweet_path(tweet, retweet)
        
        expect(response).to redirect_to(tweet)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end
    end

    context 'when is his tweet' do
      it 'should be able to delete' do
        log_in_request(user)

        retweet = create(:retweet, tweet: tweet)

        delete tweet_retweet_path(tweet, retweet)
        
        expect(response).to redirect_to(tweet)
      end
    end

    context 'when manipulating with his retweets' do
      let(:retweet) { create(:retweet, tweet: tweet) }

      before do
        log_in_request(user)
      end

      it 'should be able to update' do
        patch_params = {
          params: {
            retweet: {
              rtweet: 'Just testing'
            }
          }
        }

        patch tweet_retweet_path(tweet, retweet), patch_params

        expect(response).to redirect_to(tweet)
        follow_redirect!
        expect(response.body).to include('Just testing')
      end

      it 'should be able to delete' do
        delete tweet_retweet_path(tweet, retweet)
        
        expect(response).to redirect_to(tweet)
      end
    end
  end
end

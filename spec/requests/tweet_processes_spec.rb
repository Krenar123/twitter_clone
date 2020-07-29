require 'rails_helper'

RSpec.describe "TweetProcesses" do
  describe "As not logged in user" do
    it "should not allow to create tweet" do
      post_params = {
        params: {
          tweet: {
            tweet: "Just testing"
          }
        }
      }
      post tweets_path, post_params 

      follow_redirect!
      expect(response.body).to include('Not logged in')
    end

    it 'should not allow to update tweet' do
      tweet = create(:tweet)
      post_params = {
        params: {
          tweet: {
            tweet: "Just testing"
          }
        }
      }

      patch tweet_path(tweet), post_params 

      follow_redirect!
      expect(response.body).to include('You dont have permission to edit!')
    end

    it 'should not allow to destroy tweet' do
      tweet = create(:tweet)

      delete tweet_path(tweet)

      follow_redirect!
      expect(response.body).to include('You dont have permission to delete!')
    end

    it 'should not be able to like a tweet' do
      tweet = create(:tweet)

      post "/tweets/#{tweet.id}/likes"

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You dont have permission to like!')
    end

    it 'should not be able to dislike a tweet' do
      tweet = create(:tweet)
      like = create(:like, tweet: tweet)

      delete "/tweets/#{tweet.id}/likes/#{like.id}"

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You dont have permission to dislike!')
    end
  end

  describe 'As logged in user' do
    context 'when manipulating with tweets created by logged in user' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet, user: user) }

      it 'should allow to update' do
        post_params = {
          params: {
            ss: {
              email: user.email,
              password: user.password
            }
          }
        }
        
        post auths_login_path, post_params

        patch_params = {
          params: {
            tweet: {
              tweet: "Trying to hack it"
            }
          }
        }
        patch tweet_path(tweet), patch_params

        expect(response).to redirect_to(tweet_path(tweet))
        follow_redirect!
        expect(response.body).to include('Trying to hack it')
      end

      it 'should allow to delete' do
        post_params = {
          params: {
            ss: {
              email: user.email,
              password: user.password
            }
          }
        }
        
        post auths_login_path, post_params

        delete tweet_path(tweet)

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when trying to manipulate with other users tweets' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet, user: user) }
      let(:other_user) { create(:user) }

      before do
        post_params = {
          params: {
            ss: {
              email: other_user.email,
              password: other_user.password
            }
          }
        }
        
        post auths_login_path, post_params
      end

      it 'should allow me to like them tweets' do
        post "/tweets/#{tweet.id}/likes"

        expect(response).to redirect_to(tweet_path(tweet))
        follow_redirect!
        expect(response.body).to include('This post is liked successfully!')
      end

      it 'should not allow to edit them' do
        patch_params = {
          params: {
            tweet: {
              tweet: "Trying to hack it"
            }
          }
        }
        patch tweet_path(tweet), patch_params

        expect(response).to redirect_to(tweet_path(tweet))
        follow_redirect!
        expect(response.body).to include('You dont have permission to edit!')
      end

      it 'should not allow to delete them' do 
        delete tweet_path(tweet)

        expect(response).to redirect_to(tweet_path(tweet))
        follow_redirect!
        expect(response.body).to include('You dont have permission to delete!')
      end
    end
  end
end

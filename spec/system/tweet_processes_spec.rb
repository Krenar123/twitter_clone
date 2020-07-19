require 'rails_helper'

RSpec.describe "TweetProcesses" do
  let!(:user) { create(:user) }
  before do
    driven_by(:rack_test)

    visit root_path
    log_in(user)
  end

  describe 'creating new Tweets' do
    before do
      click_on 'Create tweets'
    end

    context ' when clicking the Create tweets link' do
      it ' should has content Tweet' do
        expect(page).to have_content('Tweet')  
      end     

      it ' should has button Create Tweet' do
        expect(page).to have_button('Create Tweet')
      end

      it ' should has link Cancel' do
        expect(page).to have_link('Cancel')
      end
    end

    context 'when submiting the tweet' do
      let(:tweet_body) { 'This tweet is test' }
      before do
        within 'form' do
          fill_in 'Tweet', with: tweet_body
        end

        click_on 'Create Tweet'
      end

      it 'should has tweet body ' do
        expect(page).to have_content(tweet_body)
      end

      it 'should has heart icon' do
        expect(page).to have_selector('i.fa-heart')
      end

      it 'should has trash icon' do
        expect(page).to have_selector('i.fa-trash')
      end

      it 'should has go back icon' do
        expect(page).to have_selector('i.fa-reply')
      end

      it 'should has retweets content' do
        expect(page).to have_content('Retweets')
      end

      it 'should has retweet button' do
        expect(page).to have_content('Retweet')
      end

      context 'when Retweeting to Tweet' do
        let(:retweet_body) { 'Just retweeting for test' }
        before do
          within 'form' do
            fill_in 'retweet_rtweet', with: retweet_body
          end
          click_on 'Retweet'
        end

        it 'should has Retweet body' do
          expect(page).to have_content(retweet_body)
        end

        it 'should has Edit link' do
          expect(page).to have_link('Edit')
        end

        it 'should has Delete link' do
          expect(page).to have_content('Delete')
        end
      end
    end
  end
end

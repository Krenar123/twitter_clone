require 'rails_helper'

RSpec.describe "AuthenticationProcesses" do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)

    visit root_path
  end

  describe 'Visiting root path while not logged in' do
    it 'has All tweets link' do
      expect(page).to have_link('All tweets')
    end

    it 'has Log In link' do
      expect(page).to have_link('Log In')
    end

    it 'has Sign Up link' do
      expect(page).to have_link('Sign Up')
    end

    it 'has content "Most likely tweets"' do
      expect(page).to have_content('Most likely tweets')
    end

    
    context 'when trying to edit or create article' do
      it 'should give a flash error for creating' do
        visit '/tweets/new'
        expect(page).to have_content('Not logged in')
      end

      it 'should give a flash error for editing' do
        create(:tweet)
        visit '/tweets/1/edit'
        expect(page).to have_content('Not logged in!')
      end
    end
  end

  describe 'Logging in and signing up' do
    context 'when logging in' do
      before do
        click_on 'Log In'
      end

      it 'has content Log in into twitter clone' do
        expect(page).to have_content('Log in into twitter clone')
      end

      context 'after submiting' do
        before do
          log_in(user)
        end

        it 'should redirect to user profile after submit' do
          expect(page).to have_content(user.email)
          expect(page).to have_link('Edit profile')
        end

        it 'should have the link  Create tweets' do
          expect(page).to have_link('Create tweets')
        end
        
        it 'should have the link Log Out' do
          expect(page).to have_link('Log Out')
        end
      end
    end

    context 'when signing up' do
      let(:name) { "Test" }

      before do
        click_on 'Sign Up'

        within 'form' do
          fill_in 'Name', with: name
          fill_in 'Email', with: 'test@gmail.com'
          fill_in 'Password', with: 'Test123!'
          fill_in 'Password confirmation', with: 'Test123!'
          click_button 'Sign up'
        end
      end

      it 'should redirect to user profile after submit' do
        expect(page).to have_content(name)
      end

      it 'should has link Edit Profile' do
        expect(page).to have_link('Edit profile')
      end

      it 'should display All tweets content ' do
        expect(page).to have_content('All tweets')
      end
    end

    context 'when there are articles present' do
      let(:user) { create(:user) }
      let!(:tweet) { create(:tweet,user: user) }
      before do
        log_in(user)
        visit root_path
      end

      it 'should has user name' do
        expect(page).to have_content(tweet.user.name)
      end

      it 'should has the tweet' do
        expect(page).to have_content(tweet.tweet)
      end

      it 'should have retweet icon' do
        expect(page).to have_selector('i.fa-retweet')
      end
    end
  end
end

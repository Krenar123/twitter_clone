module UserHelper
 def log_in(user)
    within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_button 'Login'
    end
 end
end
require 'rails_helper'
feature 'authentication feature' do
    before (:each) do
        @user = create(:user)
    end
    feature "user attempts to sign-in" do
        scenario 'visits sign-in page with email and password fields' do
            visit login_path
            expect(page).to have_field('email')
            expect(page).to have_field('password')
        end
        scenario 'logs in user if email/password is valid' do
            log_in 
            expect(current_path).to eq(show_user_path(@user.id))
            expect(page).to have_content("Welcome, #{@user.name}")
        end
        scenario 'does not sign in user if email is not valid' do
            log_in email: 'asdf@asdf.asdf'
            expect(current_path).to eq(login_path)
            expect(page).to have_content("Invalid email/password")
        end
        scenario 'does not sign in user if password is invalid' do
            log_in password: 'notpassword'
            expect(current_path).to eq(login_path)
            expect(page).to have_content("Invalid email/password")
        end
    end
    feature "user attempts to log out" do
        scenario 'displays "Log Out" button when user is logged on' do
            log_in
            expect(page).to have_button("Log Out")
        end
        scenario 'logs out user and redirects to login page' do
            log_in
            click_on 'Log Out'
            expect(current_path).to eq(login_path)
        end
    end
    feature "user attempts to access unauthorized content" do
        scenario 'redirects to login when accessing secrets without login' do
            visit secrets_path
            expect(current_path).to eq(login_path)
        end
        scenario 'redirects to login when accessing user page without login' do
            visit show_user_path(1)
            expect(current_path).to eq(login_path)
        end
        scenario 'redirects to login when accessing edit user page without login' do
            visit edit_user_path(1)
            expect(current_path).to eq(login_path)
        end
    end
    feature 'user can still access authorized pages' do
        scenario 'user may access register page' do
            visit new_user_path
            expect(current_path).to eq(new_user_path)
        end
    end
end
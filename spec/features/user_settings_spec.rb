require 'rails_helper'
feature 'User features' do
    before (:each) do 
        @user = create(:user)        
        log_in
        click_on 'Edit Profile'
    end
  feature "User Settings Dashboard" do
    scenario "visit users edit page"  do
        expect(current_path).to eq(edit_user_path(@user.id))
    end
    scenario "inputs filled out correctly" do 
        expect(find_field('name').value).to eq('Harshil Patel')
        expect(find_field('email').value).to eq('harshilp@uw.edu')
    end
    scenario "incorrectly updates information" do
        fill_in 'name', with: ''
        fill_in 'oldPassword_update', with: 'password'
        click_button 'Update'
        expect(current_path).to eq(edit_user_path(@user.id))
        expect(page).to have_content("Name can't be blank")
    end
    scenario "correctly updates information" do
        fill_in 'name', with: 'Qwerty'
        fill_in 'oldPassword_update', with: 'password'
        click_button 'Update'
        expect(page).to have_content("Welcome, Qwerty")
    end
    scenario "correctly changes password" do
        fill_in 'password', with: 'password1'
        fill_in 'password_confirmation', with: 'password1'
        fill_in 'oldPassword_change', with: 'password'
        click_button 'Change'
        click_button 'Log Out'
        log_in password: 'password1'
        expect(page).to have_content("Welcome, Harshil Patel")
    end
    scenario "destroys user and redirects to registration page" do
        click_on 'Delete'
        expect(current_path).to eq(new_user_path)
    end
  end
end
require 'rails_helper'
feature 'User features' do
  feature "user sign-up" do
    before (:each) do
      visit new_user_path
    end
    scenario 'visits sign-up page' do 
      expect(page).to have_field('name')
      expect(page).to have_field('email')
      expect(page).to have_field('password')
      expect(page).to have_field('password_confirmation')
    end
    scenario "redirects back to register and shows validations for blank fields" do
      click_button 'Register'
      expect(page).to have_content("can't be blank")
      expect(current_path).to eq(new_user_path)
    end
    scenario "redirects back to register and shows validations for email in use" do
      create(:user)
      register
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Email has already been taken')
    end
    scenario "redirects back to register and shows validations for passwords not matching" do
      register password_confirmation: 'notpassword'
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
    scenario "with proper inputs, create user, log them in and redirect to index" do
      register
      expect(page).to have_content("Welcome, Harshil Patel")
    end
  end
end

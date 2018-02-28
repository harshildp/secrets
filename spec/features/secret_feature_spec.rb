require 'rails_helper'
feature "secret features" do 
  before (:each) do
    @user = create(:user)
    @userTsu = create(:user, email: 'userTsu@tsu.com')
    @secret = create(:secret, user: @user)
    @secretTsu = create(:secret, content: "I'm scared of the dark", user: @userTsu)
    log_in
  end
  feature "Users personal secret page" do
    scenario "shouldn't see other user's secrets" do
      expect(page).to_not have_content(@secretTsu.content)
    end
    scenario "create a new secret" do
      fill_in 'content', with: 'Space kitties!'
      click_on 'Create'
      expect(page).to have_content("Space kitties!")
      expect(current_path).to eq(show_user_path(@user.id))
    end
    scenario "destroy secret from profile page, redirects to user profile page" do 
      click_on 'Delete'
      expect(page).to_not have_content('I like kitties')
    end
  end
  feature "Secret Dashboard" do 
    scenario "displays everyone's secrets" do
      visit secrets_path
      expect(page).to have_content('I like kitties')
      expect(page).to have_content("I'm scared of the dark")
    end
    scenario "destroy secret from index page, redirects to user profile page" do
      visit secrets_path
      click_on 'Delete'
      expect(current_path).to eq(show_user_path(@user.id))
      expect(page).to_not have_content('I like kitties')
    end 
  end
end
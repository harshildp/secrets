require 'rails_helper'
feature 'Like Features' do
    before (:each) do
        @user = create(:user)
        @secret = create(:secret, user: @user)
        log_in
    end
    feature 'secret has not been liked' do  
        scenario "displays like button if you haven't liked secret" do
            visit secrets_path
            expect(page).to have_content('Like')
        end
        scenario "like count updated correctly" do
            visit secrets_path
            click_on 'Like'
            expect(page).to have_content('1 -')
        end
        scenario "liking will update like count, like button not visible" do
            visit secrets_path
            click_on 'Like'
            expect(page).to_not have_content('Like')
        end
    end
    feature "secret has been liked" do    
        scenario "unlike button is visible" do
            visit secrets_path
            click_on 'Like'
            expect(page).to have_content('Unlike')
        end
        scenario "unliking will update like count" do
            visit secrets_path
            click_on 'Like'
            click_on 'Unlike'
            expect(page).to have_content('0 -')
        end
    end
end
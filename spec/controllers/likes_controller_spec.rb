require 'rails_helper'
RSpec.describe LikesController, type: :controller do 
    before do 
        @user = create(:user)
        @secret = create(:secret, user: @user)
        @like = create(:like, secret: @secret, user: @user)
    end
    context "when not logged in " do 
        before do 
            session[:user_id] = nil
        end
        it "cannot create a like" do
            get :create, id: @user
            expect(response).to redirect_to(login_path)
        end
        it "cannot destroy a like" do
            get :destroy, id: @user
            expect(response).to redirect_to(login_path)
        end
    end
    context "when signed in as the wrong user" do
        it "shouldn't be able to destroy a like" do
            session[:user_id] = 10
            get :destroy, id: @secret
            expect(response).to redirect_to(show_user_path(10))
        end
    end 
end
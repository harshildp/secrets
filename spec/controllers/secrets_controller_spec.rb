require 'rails_helper'
RSpec.describe SecretsController, type: :controller do
    before do
        @user = create(:user)
        @secret = create(:secret, user: @user)
    end
    context "when not logged in" do
        before do
            session[:user_id] = nil
        end
        it "cannot access index" do
            get :index, id: @user
            expect(response).to redirect_to(login_path)
        end
        it "cannot access create" do
            get :create, id: @user
            expect(response).to redirect_to(login_path)
        end
        it "cannot access destroy" do
            get :destroy, id: @user
            expect(response).to redirect_to(login_path)
        end
    end
    context "when signed in as the wrong user" do
        it "cannot destroy another user's secret" do
            session[:user_id] = 10
            get :destroy, id: @secret
            expect(response).to redirect_to(show_user_path(10))
        end
    end
end
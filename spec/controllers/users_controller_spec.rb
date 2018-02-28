require 'rails_helper'
RSpec.describe UsersController, type: :controller do
    before do
        @user = create(:user)
    end
    context "when not logged in" do
        before do
            session[:user_id] = nil
        end
        it "cannot access show" do 
            get :show, id: @user
            expect(response).to redirect_to(login_path)
        end
        it "cannot access edit" do
            get :edit, id: @user
            expect(response).to redirect_to(login_path)
        end
        it "cannot access update" do
            get :update, id: @user
            expect(response).to redirect_to(login_path)
        end
        it "cannot access destroy" do
            get :destroy, id: @user
            expect(response).to redirect_to(login_path)
        end
    end
    context "when signed in as the wrong user" do
        before do
            session[:user_id] = 1
        end
        it "cannot access profile page another user" do
            get :show, id: 2
            expect(response).to redirect_to(show_user_path(1))
        end
        it "cannot access the edit page of another user" do
            get :edit, id: 2
            expect(response).to redirect_to(show_user_path(1))
        end
        it "cannot update another user" do
            get :update, id: 2
            expect(response).to redirect_to(show_user_path(1))
        end
        it "cannot destroy another user" do
            get :destroy, id: 2
            expect(response).to redirect_to(show_user_path(1))
        end
    end
end
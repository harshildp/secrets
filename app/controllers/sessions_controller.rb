class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    redirect_to show_user_path(session[:user_id]) if session[:user_id]
  end

  def create
    @user = User.find_by(email:params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to show_user_path(@user.id)
    else 
      flash[:errors] = ["Invalid email/password"]
      redirect_to login_path
    end
  end

  def destroy
      reset_session
      redirect_to login_path
  end
end
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :auth, except: [:new, :create]
  def new
    redirect_to show_user_path(session[:user_id]) if session[:user_id]    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to show_user_path(@user.id)
    else 
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(session[:user_id])
    if @user && @user.authenticate(params[:oldPassword])
      if @user.update(user_params2)
        redirect_to show_user_path(@user.id)
      else 
        flash[(params[:user].has_key? 'name').to_s] = @user.errors.full_messages
        redirect_to edit_user_path
      end
    else 
      flash[(params[:user].has_key? 'name').to_s] = ['Invalid password given']
      redirect_to edit_user_path
    end
  end

  def destroy
    User.find(session[:user_id]).destroy
    reset_session    
    redirect_to new_user_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_params2
      if params[:user].has_key? 'name'
        params.require(:user).permit(:name, :email)
      else
        params.require(:user).permit(:password, :password_confirmation)
      end
    end

    def auth 
      redirect_to show_user_path(session[:user_id]) unless params[:id] == session[:user_id].to_s
    end
end

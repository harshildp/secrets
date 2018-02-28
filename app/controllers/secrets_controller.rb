class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
    @user = current_user
  end

  def create
    @secret = Secret.new(content:params[:content], user: current_user)
    if not @secret.save
      flash[:errors] = @secret.errors.full_messages
    end
    redirect_to show_user_path(session[:user_id])
  end

  def destroy
    return redirect_to show_user_path(session[:user_id]) unless Secret.find(params[:id]).user_id == session[:user_id]        
    Secret.find(params[:id]).destroy
    redirect_to show_user_path(session[:user_id])
  end
end

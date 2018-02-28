class LikesController < ApplicationController
  def create
    @like = Like.create(secret_id: params[:id], user_id: session[:user_id])
    redirect_to :back
  end

  def destroy
    return redirect_to show_user_path(session[:user_id]) unless Like.find_by(secret_id:params[:id]).user_id == session[:user_id]            
    @like = Like.where(secret_id: params[:id], user_id: session[:user_id])
    @like.first.destroy if @like.first
    redirect_to secrets_path
  end
end

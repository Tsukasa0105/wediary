class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:follow_id]) 
    current_user.follow(user) 
    if user.following?(current_user)
      flash[:success] = '友達申請を承認しました' 
    else
      flash[:success] = '友達申請しました' 
    end
    redirect_to search_users_path
  end

  def destroy
    user = User.find(params[:follow_id]) 
    current_user.unfollow(user) 
    flash[:success] = '友達を解除しました' 
    redirect_to search_users_path
  end
end

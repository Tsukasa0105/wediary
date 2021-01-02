class GroupUserPermissionsController < ApplicationController
  def create
    group = Group.find(params[:group_id]) 
    user = User.find(params[:user_id])
    group.permit_member(user) 
    flash[:success] = 'メンバー申請を承認しました' 
    redirect_to request_users_group_path(group)
  end

  def destroy
    group = Group.find(params[:group_id]) 
    user = User.find(params[:user_id])
    group.unpermit_member(user) 
    flash[:success] = 'メンバーを退会させました' 
    redirect_to request_users_group_path(group)
  end
end

class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id]) 
    current_user.member(group) 
    flash[:success] = 'メンバー申請しました' 
    redirect_to search_groups_path
  end

  def destroy
    group = Group.find(params[:group_id]) 
    current_user.unmember(group) 
    flash[:success] = 'メンバーから脱退しました' 
    redirect_to search_groups_path
  end
end

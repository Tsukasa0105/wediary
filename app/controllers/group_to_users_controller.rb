# frozen_string_literal: true

class GroupToUsersController < ApplicationController
  before_action :require_user_logged_in
  def create
    group = Group.find(params[:inviting_group_id])
    user = User.find(params[:invited_user_id])
    group.permit_member(user)
    group.create_notification_invitation(current_user, user)
    flash[:success] = 'メンバー申請を承認しました'
    redirect_to request_users_group_path(group)
  end

  def destroy
    group = Group.find(params[:inviting_group_id])
    user = User.find(params[:invited_user_id])
    group.unpermit_member(user)
    flash[:success] = 'メンバーを退会させました'
    redirect_to request_users_group_path(group)
  end
end

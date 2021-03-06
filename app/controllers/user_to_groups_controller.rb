# frozen_string_literal: true

class UserToGroupsController < ApplicationController
  before_action :require_user_logged_in
  def create
    group = Group.find(params[:group_id])
    current_user.member(group)
    redirect_to group_path(group)
  end

  def destroy
    group = Group.find(params[:group_id])
    current_user.unmember(group)
    flash[:success] = 'メンバーから脱退しました'
    redirect_to group_path(group)
  end
end

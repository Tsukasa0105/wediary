# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :require_user_logged_in
  def index
    # current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
    # @notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end

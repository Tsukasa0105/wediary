# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end
  
  def require_join_group(group)
    redirect_to login_url unless group.joined_user?
  end
end

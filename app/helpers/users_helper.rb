module UsersHelper
  def current_user?(user_id)
    logged_in? && current_user.id == user_id
  end
end

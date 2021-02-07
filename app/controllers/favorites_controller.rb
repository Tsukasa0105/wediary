
class FavoritesController < ApplicationController
   before_action :require_user_logged_in
  
  def create
    memo = Memo.find(params[:memo_id])
    current_user.favorite(memo)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    memo = Memo.find(params[:memo_id])
    current_user.unfavorite(memo)
    redirect_back(fallback_location: root_url)
  end
end

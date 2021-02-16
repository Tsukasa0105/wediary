
class FavoritesController < ApplicationController
   before_action :require_user_logged_in
  
  def create
    favorite = current_user.favorites.create!(favorite_params)
    render json: favorite
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    render json: favorite
  end
  
  def favorite_params
    params.permit(:memo_id)
  end
end

# frozen_string_literal: true

class MapsController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create]

  def index
    @map = Map.new
    @maps = Map.all
    params[:group_id]
  end

  def create
    @map = Map.new(map_params)
    if @map.save
      redirect_to new_group_event_path(@map.group_id)
    else
      @maps = Map.all
      render 'maps/index'
    end
  end

  private

  # ストロングパラメーター
  def map_params
    params.require(:map).permit(:address, :latitude, :longitude, :title, :group_id, :user_id)
  end
end

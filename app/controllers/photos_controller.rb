# frozen_string_literal: true

class PhotosController < ApplicationController
  
  before_action :require_user_logged_in,
                only: %i[show new create]
                
  def index
    @event = Event.find(params[:event_id])
    @map = Map.find_by(id: @event.map_id)   
    @photos = @event.photos.page(params[:page]).per(12)
  end
                
  def new
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @photo = @event.photos.new
  end

  def create
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    if Photo.create_photos_by(photo_params)
      flash[:success] = '写真を投稿しました'
      redirect_to group_event_path(@group, @event)
    else
      flash.now[:danger] = '写真の投稿に失敗しました'
      render :new
    end
  end

  def show
  end

  def edit; end

  def update; end

  def destroy
    @photo = Photo.find(params[:id])
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    
    @photo = Photo.find(params[:id]).destroy

    redirect_to group_event_photos_path(@group, @event)
  end

  def photo_params
    params.require(:photo).permit(:group_id, { images:[] }, :event_id, :image)
  end
end

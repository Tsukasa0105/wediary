# frozen_string_literal: true

class PhotosController < ApplicationController
  
  before_action :require_user_logged_in,
                only: %i[show new create]
                
  def index
    @event = Event.find(params[:event_id])
    @photos = @event.photos
    @map = Map.find_by(id: @event.map_id)    
  end
                
  def new
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @photo = @event.photos.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = '写真を投稿しました'
      redirect_to group_event_path(@photo.event.group, @photo.event)
    else
      flash.now[:danger] = '写真の投稿に失敗しました'
      render :new
    end
  end

  def show
  end

  def edit; end

  def update; end

  def destroy; end

  def photo_params
    params.require(:photo).permit(:group_id, { images: [] }, :event_id)
  end
end

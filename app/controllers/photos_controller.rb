class PhotosController < ApplicationController
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
    @photo = Photo.find(params[:id])
    @event = @photo.event
    @map = Map.find_by(id: @event.map_id)
  end


  def edit
  end

  def update
  end

  def destroy
  end
  
  def photo_params
    params.require(:photo).permit(:group_id, {images: []}, :event_id)
  end
end

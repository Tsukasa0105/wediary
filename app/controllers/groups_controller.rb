class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :group_users] 
  before_action :require_user_logged_in, only: [:index, :show, :new, :create, :edit, :update, :search, :destroy, :group_users, :request_users]

  def index 
    if logged_in?
      @groups = current_user.join_groups
    end
  end
  
  def show
      @events = @group.events
      @request_users = @group.request_users
      @invited_users = @group.invited_users
      @only_request_users = @request_users - @invited_users
      @joined_users = @request_users & @invited_users
      gon.group_maps = Map.where(group_id: @group.id)
      if params[:from] and params[:from] != "" and params[:to] and params[:to] != ""
          @sort_events = Event.where(event_date: params[:from]..params[:to]) & @group.events
      elsif params[:from] and params[:from] != ""
          @sort_events = Event.where('event_date >= ?', params[:from]) & @group.events
      elsif params[:to] and params[:to] != ""
          @sort_events = Event.where('event_date <= ?', params[:to]) & @group.events
      else
          @sort_events = @group.events
      end
      gon.sort_group_maps =[]
      @sort_events.each do |event|
        gon.sort_group_maps.push(event.map)
      end
  end

  def new
    @group = Group.new
    @group.group_user_permissions.build
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'グループを作成しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'グループを作成できませんでした'
      render :new
    end
  end
  
  def update 
    if @group.update(group_params)
      flash[:success] = 'グループを更新しました'
      redirect_to group_path(@group)
    else
      flash.now[:danger] = 'グループを更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    Group.destroy(params[:id])

    flash[:success] = '正常に削除されました'
    redirect_to root_path
  end
  
  def search
    if params[:key] and params[:key] != ""
        @groups = Group.where(key: params[:key])
    else
        @groups = Group.where(id: nil) 
    end
  end
  
  def group_users
    @request_users = @group.request_users
    @invited_users = @group.invited_users
    @joined_users = @request_users & @invited_users
  end
  
  def request_users
    @group = Group.find(params[:id])
    @request_users = @group.request_users
  end

  private
  
  def group_params
    params.require(:group).permit(:image, :name, :key, {invited_user_ids: []})
  end
  
  def set_group
    @group = Group.find(params[:id])
  end
end

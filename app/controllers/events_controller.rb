# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :require_user_logged_in, only: %i[show new create edit update destroy]

  def show
    @event = Event.find(params[:id])
    @photos = @event.photos.page(params[:page]).per(4)
    @number = 1
    @group = @event.group
    @map = Map.find_by(id: @event.map_id)
    @pay_records = @event.pay_records.page(params[:page]).per(5)
    @memos = @event.memos.limit(3).sort { |a, b| b.favorite_users.count <=> a.favorite_users.count }
    gon.current_user = current_user
    @memo = Memo.new
  end

  def new
    @group = Group.find(params[:group_id])
    @event = @group.events.new
    @map = Map.new
    @maps = Map.all
    params[:group_id]
  end

  def create
    @event = Event.new(event_params)
    @group = Group.find(params[:group_id])
    if @group.joined_user?(current_user)
      if @event.save
        @event.create_notification_new_event(current_user, @event.group)
        redirect_to group_event_path(@event.group, @event)
        flash[:success] = 'イベントを作成しました'
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @group = Group.find(params[:group_id])
    if @group.joined_user?(current_user)
      if @event.update(event_params)
        redirect_to group_event_path(@event.group, @event)
        flash[:success] = 'イベントを編集しました'
      else
        render :edit
      end
    else
      case params[:order_sort]
      when '1'
        render 'photos/new'
      else
        render :edit
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @group = Group.find(params[:group_id])
    if @group.joined_user?(current_user)
      @event.destroy
      flash[:success] = '正常に削除されました'
      redirect_to group_path(@group)
    else
      redirect_to root_path
    end
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_time, :group_id, :user_id, :map_id, :image)
  end
end

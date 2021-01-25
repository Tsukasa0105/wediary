# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :require_user_logged_in, only: %i[show new create edit update destroy]

  def show
    @event = Event.find(params[:id])
    @photos = @event.photos
    @group = @event.group
    @map = Map.find_by(id: @event.map_id)
    @pay_records = @event.pay_records
    # @amount_per_person = pay_record.amount/pay_record.users.count
  end

  def new
    @group = Group.find(params[:group_id])
    @event = @group.events.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to group_event_path(@event.group, @event)
      flash.now[:success] = 'イベントを作成しました'
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
    if @event.update(event_params)
      redirect_to group_event_path(@event.group, @event)
      flash.now[:success] = 'イベントを編集しました'
    else
      render :new
    end
  end

  def destroy
    @event.destroy

    flash[:success] = '正常に削除されました'
    redirect_to root_path
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_time, :group_id, :user_id, :map_id, :image)
  end
end

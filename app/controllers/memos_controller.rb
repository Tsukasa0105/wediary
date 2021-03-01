# frozen_string_literal: true

class MemosController < ApplicationController
  before_action :require_user_logged_in, only: %i[index new create destroy]

  def index
    @event = Event.find(params[:event_id])
    @group = @event.group
    @memos = @event.memos.page(params[:page]).per(10)
  end

  def new
    @event = Event.find(params[:event_id])
    @group = @event.group
    @memo = @event.memos.new
  end

  def create
    @memo = Memo.new(memo_params)
    @event = Event.find(params[:event_id])
    @group = @event.group
    @event.create_notification_edit_event(current_user, @group)
    if @group.joined_user?(current_user)
      if @memo.save
        redirect_to group_event_path(@group, @event)
        flash[:success] = 'メモを作成しました'
      else
        render :new
        flash.now[:danger] = 'メモを作成できませんでした'
      end
    else
      render :new
      flash.now[:danger] = 'メモを作成できませんでした'
    end  
  end

  def destroy
    @memo = Memo.find(params[:id])
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    @memos = @event.memos
    if @group.joined_user?(current_user)
      @memo.destroy
    else
      redirect_to root_path
    end
  end

  def memo_params
    params.require(:memo).permit(:title, :content, :event_id, :user_id)
  end
end

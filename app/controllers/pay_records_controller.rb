# frozen_string_literal: true

class PayRecordsController < ApplicationController
  before_action :require_user_logged_in, only: %i[new create destroy pay_users]

  def new
    @event = Event.find(params[:event_id])
    @group = @event.group
    @pay_record = @event.pay_records.new
  end

  def create
    @pay_record = PayRecord.new(pay_record_params)
    @event = Event.find(params[:event_id])
    @group = @event.group
    @event.create_notification_edit_event(current_user, @group)
    if @group.joined_user?(current_user)
      if @pay_record.save
        @pay_record.initial_user_ids = @pay_record.user_ids
        @pay_record.save
        redirect_to group_event_path(@group, @event)
        flash[:success] = '精算記録を作成しました'
      else
        render :new
        flash.now[:danger] = '精算記録を作成できませんでした'
      end
    else
      render :new
      flash.now[:danger] = '精算記録を作成できませんでした'
    end
  end

  def destroy
    @pay_record = PayRecord.find(params[:id])
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
    if @group.joined_user?(current_user)
      @pay_record = PayRecord.find(params[:id]).destroy
    else
      redirect_to root_path
    end
  end

  def pay_users
    @pay_record = PayRecord.find(params[:id])
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id])
  end

  def pay_record_params
    params.require(:pay_record).permit(:name, :amount, :paied_user_id, { user_ids: [] }, { initial_user_ids: [] },
                                       :event_id)
  end
end

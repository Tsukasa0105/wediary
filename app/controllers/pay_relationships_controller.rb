# frozen_string_literal: true

class PayRelationshipsController < ApplicationController
  before_action :require_user_logged_in
  def create
    @user = User.find(params[:user_id])
    @pay_record = PayRecord.find(params[:pay_record_id])
    @user.need_pay(@pay_record)
    
    if params[:situation] == "modal"
      redirect_to group_event_path(@pay_record.event.group, @pay_record.event)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @pay_record = PayRecord.find(params[:pay_record_id])
    @user.paied(@pay_record)
    
    # if params[:situation] == "modal"
    #   redirect_to group_event_path(@pay_record.event.group, @pay_record.event)
    # end
    
  end
end

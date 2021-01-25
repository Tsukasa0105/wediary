# frozen_string_literal: true

class PayRelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    pay_record = PayRecord.find(params[:pay_record_id])
    user.need_pay(pay_record)
    redirect_to group_event_path(pay_record.event.group, pay_record.event)
  end

  def destroy
    user = User.find(params[:user_id])
    pay_record = PayRecord.find(params[:pay_record_id])
    user.paied(pay_record)
    redirect_to group_event_path(pay_record.event.group, pay_record.event)
  end
end

# frozen_string_literal: true

class PayRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @pay_record = PayRecord.find(params[:pay_record_id])
    @user.need_pay(@pay_record)
  end

  def destroy
    @user = User.find(params[:user_id])
    @pay_record = PayRecord.find(params[:pay_record_id])
    @user.paied(@pay_record)
  end
end

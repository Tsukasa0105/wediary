# frozen_string_literal: true

class InitialPayRelationshipsController < ApplicationController
  before_action :require_user_logged_in
  def create
    initial_user = User.find(params[:initial_user_id])
    initial_pay_record = PayRecord.find(params[:pay_record_id])
    initial_user.initial_pay(initial_pay_record)
    redirect_to root_path
  end
end

# frozen_string_literal: true

class ToppagesController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
end

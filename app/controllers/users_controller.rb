# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user_logged_in,
                only: %i[index show edit update search followings followers friends requested_groups inviting_groups
                         join_groups]
  before_action :set_user, only: [:show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(20)
  end

  def new
    @user = User.new
  end

  def show
    @groups = @user.join_groups
    @events = []
    @groups.each do |group|
      @events.concat(group.events)
    end
    gon.group_maps = []
    @groups.each do |group|
      gon.group_maps.concat(Map.where(group_id: group.id))
    end
    @sort_events = if params[:from] && (params[:from] != '') && params[:to] && (params[:to] != '')
                     Event.where(event_date: params[:from]..params[:to]) & @events
                   elsif params[:from] && (params[:from] != '')
                     Event.where('event_date >= ?', params[:from]) & @events
                   elsif params[:to] && (params[:to] != '')
                     Event.where('event_date <= ?', params[:to]) & @events
                   else
                     @user.events
                   end
    gon.sort_group_maps = []
    @sort_events.each do |event|
      gon.sort_group_maps.push(event.map)
    end
    case params[:sort]
    when 'new'
      @join_groups = @user.join_groups.sort_by { |f| f[:updated_at] }.reverse!
      @join_groups = Kaminari.paginate_array(@groups).page(params[:page]).per(12)
      @inviting_groups = @user.only_inviting_groups.sort_by { |f| f[:updated_at] }.reverse!
      @inviting_groups = Kaminari.paginate_array(@inviting_groups).page(params[:page]).per(12)
      @requested_groups = @user.only_requested_groups.sort_by { |f| f[:updated_at] }.reverse!
      @requested_groups = Kaminari.paginate_array(@requested_groups).page(params[:page]).per(12)
    when 'old'
      @join_groups = @user.join_groups.sort_by { |f| f[:updated_at] }
      @join_groups = Kaminari.paginate_array(@groups).page(params[:page]).per(12)
      @inviting_groups = @user.only_inviting_groups.sort_by { |f| f[:updated_at] }
      @inviting_groups = Kaminari.paginate_array(@inviting_groups).page(params[:page]).per(12)
      @requested_groups = @user.only_requested_groups.sort_by { |f| f[:updated_at] }
      @requested_groups = Kaminari.paginate_array(@requested_groups).page(params[:page]).per(12)
    when 'name'
      @join_groups = @user.join_groups.sort_by { |f| f[:name] }
      @join_groups = Kaminari.paginate_array(@groups).page(params[:page]).per(12)
      @inviting_groups = @user.only_inviting_groups.sort_by { |f| f[:name] }
      @inviting_groups = Kaminari.paginate_array(@inviting_groups).page(params[:page]).per(12)
      @requested_groups = @user.only_requested_groups.sort_by { |f| f[:name] }
      @requested_groups = Kaminari.paginate_array(@requested_groups).page(params[:page]).per(12)
    else
      @join_groups = Kaminari.paginate_array(@user.join_groups).page(params[:page]).per(12)
      @inviting_groups = Kaminari.paginate_array(@user.only_inviting_groups).page(params[:page]).per(12)
      @requested_groups = Kaminari.paginate_array(@user.only_requested_groups).page(params[:page]).per(12)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を変更しました'
        redirect_to user_path(@user)
      else
        flash.now[:danger] = 'ユーザー情報の変更に失敗しました'
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  #destroyは実装しない
  # def destroy
  #   @user.destroy

  #   flash[:success] = '正常に削除されました'
  #   redirect_to tasks_url
  # end

  def search
    @users = if params[:id] && (params[:id] != '')
               User.where(id: params[:id])
             else
               User.all
             end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers - followings.page(params[:page])
  end

  def friends
    @friends = @user.friends
  end

  def join_groups
    @groups = @user.join_groups
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

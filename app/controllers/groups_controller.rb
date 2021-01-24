class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update group_users]
  before_action :require_user_logged_in,
                only: %i[index show new create edit update search destroy group_users request_users]

  def index
    if logged_in?
      if params[:sort] == "new"
        @groups = current_user.join_groups.sort_by{|f| f[:updated_at]}.reverse!
        @groups = Kaminari.paginate_array(@groups).page(params[:page]).per(12)
        @inviting_groups = current_user.join_groups.sort_by{|f| f[:updated_at]}.reverse!
        @inviting_groups = Kaminari.paginate_array(@inviting_groups).page(params[:page]).per(12)
        @requested_groups = current_user.join_groups.sort_by{|f| f[:updated_at]}.reverse!
        @requested_groups = Kaminari.paginate_array(@requested_groups).page(params[:page]).per(12)
      elsif params[:sort] == "old"
        @groups = current_user.join_groups.sort_by{|f| f[:updated_at]}
        @groups = Kaminari.paginate_array(@groups).page(params[:page]).per(12)
        @inviting_groups = current_user.join_groups.sort_by{|f| f[:updated_at]}
        @inviting_groups = Kaminari.paginate_array(@inviting_groups).page(params[:page]).per(12)
        @requested_groups = current_user.join_groups.sort_by{|f| f[:updated_at]}
        @requested_groups = Kaminari.paginate_array(@requested_groups).page(params[:page]).per(12)
      elsif params[:sort] == "name"
        @groups = current_user.join_groups.sort_by{|f| f[:name]}
        @groups = Kaminari.paginate_array(@groups).page(params[:page]).per(12)
        @inviting_groups = current_user.join_groups.sort_by{|f| f[:name]}
        @inviting_groups = Kaminari.paginate_array(@inviting_groups).page(params[:page]).per(12)
        @requested_groups = current_user.join_groups.sort_by{|f| f[:name]}
        @requested_groups = Kaminari.paginate_array(@requested_groups).page(params[:page]).per(12)
      else
        @groups = Kaminari.paginate_array(current_user.join_groups).page(params[:page]).per(12)
        @inviting_groups = Kaminari.paginate_array(current_user.only_inviting_groups).page(params[:page]).per(12)
        @requested_groups = Kaminari.paginate_array(current_user.only_requested_groups).page(params[:page]).per(12)
      end
    end
  end

  def show
    @events = @group.events
    @request_users = @group.request_users
    @invited_users = @group.invited_users
    @only_request_users = @request_users - @invited_users
    @joined_users = @request_users & @invited_users
    gon.group_maps = Map.where(group_id: @group.id)
    @sort_events = if params[:from] && (params[:from] != '') && params[:to] && (params[:to] != '')
                     Event.where(event_date: params[:from]..params[:to]) & @group.events
                   elsif params[:from] && (params[:from] != '')
                     Event.where('event_date >= ?', params[:from]) & @group.events
                   elsif params[:to] && (params[:to] != '')
                     Event.where('event_date <= ?', params[:to]) & @group.events
                   else
                     @group.events
                   end
    gon.sort_group_maps = []
    @sort_events.each do |event|
      gon.sort_group_maps.push(event.map)
    end
  end

  def new
    @group = Group.new
    @group.group_to_users.build
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'グループを作成しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'グループを作成できませんでした'
      render :new
    end
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'グループを更新しました'
      redirect_to group_path(@group)
    else
      flash.now[:danger] = 'グループを更新できませんでした'
      render :edit
    end
  end

  def destroy
    Group.destroy(params[:id])

    flash[:success] = '正常に削除されました'
    redirect_to root_path
  end

  def search
    @groups = if params[:key] && (params[:key] != '')
                Group.where(key: params[:key])
              else
                Group.where(id: nil)
              end
  end

  def group_users
    @request_users = @group.request_users
    @invited_users = @group.invited_users
    @joined_users = @request_users & @invited_users
  end

  def request_users
    @group = Group.find(params[:id])
    @request_users = @group.request_users
  end

  private

  def group_params
    params.require(:group).permit(:image, :name, :key, { invited_user_ids: [] }, :keyword)
  end

  def set_group
    @group = Group.find(params[:id])
  end
  
end

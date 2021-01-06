class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :search, :followings, :followers, :friends, :requested_groups, :inviting_groups, :join_groups]
  before_action :set_user, only: [:show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(20)
  end

  def new
    @user=User.new
  end

  def show
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
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を変更しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザー情報の変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @user.destroy

    flash[:success] = '正常に削除されました'
    redirect_to tasks_url
  end

  def search
    if params[:id] and params[:id] != ""
        @users = User.where(id: params[:id])
    else
        @users = User.all 
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    # counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    # counts(@user)
  end
  
  def friends
    @friends = current_user.friends
  end
  
  def requested_groups
    @groups = current_user.only_requested_groups
  end

  def inviting_groups
    @groups = current_user.only_inviting_groups
  end

  def join_groups
    @groups = current_user.join_groups
  end
  
  # def like_hobbies
  #   @user = User.find(params[:id])
  #   @like_hobbies = @user.like_hobbies.page(params[:page])
  #   counts(@user)
  # end
  
  # def like_ways
  #   @user = User.find(params[:id])
  #   @like_ways = @user.like_ways.page(params[:page])
  #   counts(@user)
  # end
  
  # def satisfied_ways
  #   @user = User.find(params[:id])
  #   @satisfied_ways = @user.satisfied_ways.page(params[:page])
  #   counts(@user)
  # end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end 

  def set_user
    @user = User.find(params[:id])
  end
  
end

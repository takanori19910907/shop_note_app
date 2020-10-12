class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:edit,:update,:destroy]
  before_action :correct_user, only: [:join]
  before_action :set_group, only: [:edit,:update,:destroy,:join,:show,:chatroom]

  def index
    @groups = current_user.groups
  end

  def new
    @group = current_user.own_groups.new
  end

  def create
    ActiveRecord::Base.transaction do
      @group = current_user.own_groups.new(group_params)
      @group.save!
      group_member = @group.group_members.build(user_id: current_user.id, activated: true)
      group_member.save!
    end
      flash[:success] = 'グループを作成しました'
      redirect_to group_path(@group)

      rescue => e
        flash[:danger] = 'グループ作成に失敗しました。再度やり直してください'
        render 'groups/new'
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:success] = "グループ情報を変更しました"
    else
      flash[:danger] = "グループ情報変更に失敗しました。再度やり直してください"
    end
      redirect_to group_path(@group)
  end

  def destroy
    @group.destroy
    flash[:success] = "グループを削除しました"
    redirect_to root_path
  end

  def invite
    if params[:id].to_i != current_user.id
      @group = Group.find(params[:group_id])
      @member = @group.group_members.create(user_id: params[:id])
      flash[:success] = "#{@member.user.name}さんを招待しました"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = '無効な処理です。自分以外のユーザーへリクエストしてください'
      redirect_to request.referrer || root_url
    end
  end

  def invite_reset
    @group = Group.find(params[:group_id])
    @group.group_members.find_by(user_id: params[:id]).destroy
    redirect_to request.referrer || root_url
  end

  def join
    @group.group_members.find_by(user_id: params[:user_id]).update(activated: true)
    flash[:success] = 'グループに参加しました'
    redirect_to chatroom_group_path
  end

  def show
    @members = @group.group_members.where(activated: true)
  end

  def chatroom
    @group_notes = Note.includes([comments: :user]).where(group_id: @group.id)
    @members = @group.users.select(:name)
  end

  def request_list
  end

  private

  def correct_user
    unless params[:user_id].to_i == current_user.id
      flash[:danger] = '本人でないためグループリクエストの承認が出来ません'
      redirect_to request.referrer || root_url
    end
  end

  def admin_user
    group = current_user.groups.find(params[:id])
    unless group.admin_user_id == current_user.id
      flash[:danger] = '管理者権限がないため実行出来ません'
      render 'home/index'
    end
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:image, :name, :profile)
  end

  def join_params
    params.permit(:user_id)
  end
end

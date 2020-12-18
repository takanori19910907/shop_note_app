class SearchesController < ApplicationController

  def top
  end

  def index
    if params[:group_id].present?
      @group = Group.find_by(id: params[:group_id])
      if params[:name].present?
        @search_users = User.where('name LIKE ?', "%#{params[:name]}%")
      else
        flash[:danger] = '指定のユーザーは存在しません'
        @users = User.none
      end
    else
      @group = []
      @groups = current_user.groups.all
      @search_users = User.where('name LIKE ?', "%#{params[:name]}%")
      render 'searches/index'
    end
  end
end

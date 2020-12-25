class SearchesController < ApplicationController

  def top
  end

  def index
    if params[:group_id].present?
      @group = Group.find_by(id: params[:group_id])
      if params[:name].present?
        # @search_users = User.where("name LIKE ?", "%#{params[:name]}%")
        @search_users = User.where("name LIKE ?", "%#{params[:name]}%").page(params[:page]).per(10)

      else
        flash[:danger] = "指定のユーザーは存在しません"
        @users = User.none
        @search_users = User.none.page(params[:page])
      end
    else
      if params[:name].present?
        @group = []
        @groups = current_user.groups.all
        # @search_users = User.where("name LIKE ?", "%#{params[:name]}%")
        @search_users = User.where("name LIKE ?", "%#{params[:name]}%").page(params[:page]).per(10)
      else
        flash[:danger] = "指定のユーザーは存在しません"
        @users = User.none
        @search_users = User.none.page(params[:page])
      end
      render "searches/index"
    end
  end
end

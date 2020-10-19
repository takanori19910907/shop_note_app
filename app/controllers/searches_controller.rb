class SearchesController < ApplicationController


  def top
  end

  def index
      binding.pry
      @group = Group.find_by(id: params[:group_id])
      if @group.present?
        @search_users = User.where('name LIKE ?', "%#{params[:name]}%")
        if @search_users.present? && params[:name].present?
          @search_users
        else
          @search_users = []
        end
    else
      @group = []
      @groups = current_user.groups.all
      @search_users = User.where('name LIKE ?', "%#{params[:name]}%")
      if @search_users.present? && params[:name].present?
        @search_users
      else
        @search_users = []
      end
      render 'searches/index'
    end
  end
end

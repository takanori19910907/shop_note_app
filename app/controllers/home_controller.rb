class HomeController < ApplicationController
  before_action :note_present?, only: [:index,:t_post,:t_index]
  before_action :set_items, only: [:t_create,:t_favItem_post]
  def index
  end

  def help
  end

  def t_top
  end

  def t_post
  end

  def t_index
  end


  def t_create
    @favorite_item = current_user.favorite_items.new
  end

  def t_favItem_post
  end

  private
    def note_present?
      if current_user.present?
        @own_notes = current_user.notes.includes(comments: :user)
        @note = current_user.notes.build
      else
        @own_notes = []
      end
    end

    def set_items
      favorite_items = current_user.favorite_items.all
      @favorite_item_groups = current_user.favorite_item_groups
      @item_exists = favorite_items.present?
    end
end

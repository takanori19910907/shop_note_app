class HomeController < ApplicationController

  def top
    if user_signed_in?
    render 'notes/index'
    end
  end

  def index
  end

  def help
  end
end

class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.feed.paginate page: params[:page],
      per_page: Settings.activity_page
    end
  end
end

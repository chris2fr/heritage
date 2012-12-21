class ApplicationController < ActionController::Base
  layout :choose_layout
  protect_from_forgery

  before_filter :set_photographer

  protected
  def set_photographer
    if is_admin_interface?
      @current_photographer = @photographer = current_user
    else
      @current_photographer = User.find_by_specific_url(request.server_name, :include => [:stories])
      # use request.host ? raise ActiveRecord::RecordNotFound ?
      @photographer ||= @current_photographer
    end
  end

  def choose_layout
    "fixedlayout"
    "adminfixed"
  end

  def get_story
    story_id = params[:story_id] || params[:id]
    @story = current_user.stories.find_by_permalink(story_id, :include => [:photos]) ||
      current_user.stories.find(story_id, :include => [:photos])

    raise ActiveRecord::RecordNotFound unless @story
  end

  def get_stories
    return unless @photographer

    @stories = @photographer.stories
  end

  def is_admin_interface?
    ['admin.minideb.local', 'admin.heritage.io'].include? request.server_name
  end
end

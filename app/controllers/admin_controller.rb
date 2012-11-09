class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to :controller => "accounts", :action => "stories"
  end
end

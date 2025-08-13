class Admin::BaseController < ApplicationController
  before_action :require_staff!

  private

  def require_staff!
    redirect_to root_path unless Current.user&.staff?
  end
end

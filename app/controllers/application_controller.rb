class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_required
    unless current_user.is_admin?
      flash[:alert] = "不是管理员"
      redirect_to "/"
    end
  end
end

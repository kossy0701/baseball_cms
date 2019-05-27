class Admin::ActivityLogsController < Admin::Base

  before_action :admin_login_required

  def index
    @activity_logs = ActivityLog.order('created_at DESC').page(params[:page]).per(15)
  end

end

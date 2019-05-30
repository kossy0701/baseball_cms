class Admin::ActivityLogsController < Admin::Base

  before_action :admin_login_required

  def index
    @activity_logs = ActivityLog.order('created_at DESC').page(params[:page]).per(15)

    respond_to do |format|
      format.html
      format.csv { send_data ActivityLog.generate_csv, filename: "log-#{Time.zone.now.strftime('%Y%M%D%S')}.csv" }
    end
  end

end

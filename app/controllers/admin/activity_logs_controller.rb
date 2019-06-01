class Admin::ActivityLogsController < Admin::Base

  before_action :admin_login_required
  after_action :create_download_csv_log, only: :download
  def index
    @activity_logs = ActivityLog.order('created_at DESC').page(params[:page]).per(15)
  end

  def download
    respond_to do |format|
      format.csv { send_data ActivityLog.generate_csv, filename: "log-#{Time.zone.now.strftime('%Y%M%D%S')}.csv" }
    end
  end

  private

  def create_download_csv_log
    ActivityLog.create! log_type: :log_csv, performer: current_member, performed_at: Time.now
  end

end

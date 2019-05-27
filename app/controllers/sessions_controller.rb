class SessionsController < ApplicationController
  after_action :create_login_log, only: :create
  before_action :prepare_create_logout_log, only: :destroy
  after_action :create_logout_log, only: :destroy

  def create
    member = Member.find_by name: params[:name]
    if member&.authenticate params[:password]
      session[:member_id] = member.id
      flash[:notice] = 'ログインしました'
    else
      flash[:alert] = '名前とパスワードが一致しません'
    end
    redirect_to root_path
  end

  def destroy
    session.delete :member_id
    redirect_to root_path
  end


  private

  def create_login_log
    case current_member
    when Member
      ActivityLog.create! log_type: :login, performer: current_member, performed_at: Time.now
    end
  end

  def prepare_create_logout_log
    @old_resource = current_member
  end

  def create_logout_log
    case @old_resource
    when Member
      ActivityLog.create! log_type: :logout, performer: @old_resource, performed_at: Time.now
    end
  end

end

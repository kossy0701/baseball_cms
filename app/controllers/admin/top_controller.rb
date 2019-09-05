class Admin::TopController < Admin::Base
  before_action :admin_login_required

  def index; end
end

class Admin::MembersController < Admin::Base
  before_action :admin_login_required
  before_action :set_member, only: %i[show edit update destroy]
  after_action :create_download_csv_log, only: :download

  def index
    @member_search_form = MemberSearchForm.new member_search_params
    @members = Member.order('number').page(params[:page]).per(15)
  end

  def new
    @member = Member.new birthday: Date.new(1980, 1, 1)
  end

  def create
    @member = Member.new member_permit_params
    if @member.save
      flash[:notice] = '会員を登録しました'
      redirect_to admin_member_path(@member)
    else
      flash.now[:alert] = '会員登録に失敗しました'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @member.update member_permit_params
      flash[:notice] = '会員情報を更新しました'
      redirect_to admin_member_path
    else
      flash.now[:alert] = '会員情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @member.id == current_member.id
      flash.now[:alert] = '自分のアカウントは削除できません'
      render :show
    else
      @member.destroy
      flash[:notice] = '会員を削除しました'
      redirect_to admin_members_path
    end
  end

  def search
    @member_search_form = MemberSearchForm.new member_search_params
    @members = @member_search_form.search params[:q]
    @members = @members.page(params[:page]).per(15)
    render :index
  end

  def download
    respond_to do |format|
      format.csv { send_data Member.generate_csv, filename: "member-#{Time.zone.now.strftime('%Y%M%D%S')}.csv" }
    end
  end

  private

  def set_member
    @member = Member.find(params[:id]).decorate
  end

  def member_search_params
    params.permit(:name, :full_name)
  end

  def member_permit_params
    attrs = %i[new_profile_picture remove_profile_picture number name full_name sex birthday prefecture_id email administrator]
    attrs << %i[password password_confirmation] if params[:action] == 'create'
    params.require(:member).permit(attrs)
  end

  def create_download_csv_log
    ActivityLog.create! log_type: :member_csv, performer: current_member, performed_at: Time.now
  end
end

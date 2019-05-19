class MembersController < ApplicationController

  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @member_search_form = MemberSearchForm.new member_search_params
    @members = Member.order 'number'
  end

  def new
    @member = Member.new birthday: Date.new(1980, 1, 1)
  end

  def create
    @member = Member.new member_permit_params
    if @member.save
      flash[:notice] = '会員を登録しました。'
      redirect_to members_path
    else
      flash.now[:alert] = '会員登録に失敗しました。'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @member.update member_permit_params
      flash[:notice] = '会員情報を更新しました。'
      redirect_to members_path
    else
      flash.now[:alert] = '会員情報の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    if @member.destroy
      flash[:notice] = '会員を削除しました。'
      redirect_to members_path
    else
      flash.now[:alert] = '会員の削除に失敗しました。'
      render :new
    end
  end

  def search
    @member_search_form = MemberSearchForm.new member_search_params
    @members = @member_search_form.search params[:q]
    render :index
  end

  private

  def set_member
    @member = Member.find params[:id]
  end

  def member_search_params
    params.permit(:name, :full_name)
  end

  def member_permit_params
    params.require(:member).permit(:number, :name, :full_name, :gender, :birthday, :prefecture_id, :email, :password, :password_confirmation)
  end

end


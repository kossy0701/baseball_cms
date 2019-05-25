class AccountsController < ApplicationController

  before_action :login_required
  before_action :set_member

  def show
  end

  def edit
  end

  def update
    @member.assign_attributes account_params
    if @member.save
      redirect_to account_path, notice: 'アカウント情報を更新しました。'
    else
      flash.now[:alert] = 'アカウント情報の更新に失敗しました。'
      render :edit
    end
  end

  private

  def set_member
    @member = current_member.decorate
  end

  def account_params
    params.require(:account).permit(:number, :name, :full_name, :sex, :birthday, :email)
  end

end

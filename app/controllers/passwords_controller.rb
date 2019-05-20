class PasswordsController < ApplicationController

  before_action :login_required
  before_action :set_member, only: [:edit, :update]

  def show
    redirect_to account_path
  end

  def edit
  end

  def update
    current_password = params[:account][:current_password]

    if current_password.present?
      if @member.authenticate current_password
        binding.pry
        @member.assign_attributes account_params
        if @member.save
          redirect_to account_path, notice: 'パスワードを変更しました。'
        else
          render :edit
        end
      else
        @member.errors.add(:current_password, :wrong)
        render :edit
      end
    else
      @member.errors.add(:current_password, :empty)
      render :edit
    end
  end

  private

  def set_member
    @member = current_member
  end

  def account_params
    params.require(:account).permit(:current_password, :password, :password_confirmation)
  end
end
class MembersController < ApplicationController

  before_action :set_member, only: :show

  def index
    @member_search_form = MemberSearchForm.new member_search_params
    @members = Member.order('number').page(params[:page]).per(15)
  end


  def show
  end

  def search
    @member_search_form = MemberSearchForm.new member_search_params
    @members = @member_search_form.search params[:q]
    @members = @members.page(params[:page]).per(15)
    render :index
  end

  private

  def set_member
    @member = Member.find(params[:id]).decorate
  end

  def member_search_params
    params.permit(:name, :full_name)
  end

end


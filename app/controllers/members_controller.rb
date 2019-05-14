class MembersController < ApplicationController

  before_action :set_member, only: [:show, :update, :destroy]

  def index
    @member_search_form = MemberSearchForm.new(member_search_params)
    @members = Member.order 'number'
  end

  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  def search
    @member_search_form = MemberSearchForm.new(member_search_params)
    @members = @member_search_form.search(params[:q])
    render :index
  end

  private

  def set_member
    @member = Member.find params[:id]
  end

  def member_search_params
    params.permit(:name, :full_name)
  end

end


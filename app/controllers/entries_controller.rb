class EntriesController < ApplicationController

  before_action :login_required, except: [:index, :show]

  def index
    if params[:member_id]
      @member = Member.find params[:member_id]
      @entries = @member.entries
    else
      @entries = Entry.all
    end

    @entries = @entries.readable_for(current_member).order(posted_at: :desc).page(params[:page]).per(3)
  end

  def new
    @entry = Entry.new(posted_at: Time.now)
  end

  def create
    @entry = Entry.new(entry_permit_params)
    @entry.author = current_member
    if @entry.save
      redirect_to entry_path(@entry), notice: 'ブログを作成しました'
    else
      flash.now[:alert] = 'ブログの作成に失敗しました'
      render :new
    end
  end

  def show
    @entry = Entry.readable_for(current_member).find params[:id]
  end

  def edit
    @entry = current_member.entries.find params[:id]
  end

  def update
    @entry = current_member.entries.find params[:id]
    @entry.assign_attributes(entry_permit_params)
    if @entry.save
      redirect_to entry_path(@entry), notice: 'ブログを更新しました'
    else
      flash.now[:alert] = 'ブログの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @entry = current_member.entries.find params[:id]
    @entry.destroy
    redirect_to entries_path, notice: 'ブログを削除しました'
  end

  private

  def entry_permit_params
    params.require(:entry).permit(:member_id, :title, :body, :posted_at, :status)
  end

end

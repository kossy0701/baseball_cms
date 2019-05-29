class EntriesController < ApplicationController

  before_action :login_required, except: [:index, :show]

  def index
    if params[:member_id]
      @member = Member.find params[:member_id]
      @entries = @member.entries
    else
      @entries = Entry.all
    end

    @entries = @entries.readable_for(current_member).order(posted_at: :desc).page(params[:page]).per(5)
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
    @entry = @entry.decorate
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

  def like
    @entry = Entry.published.find params[:id]
    current_member.voted_entries << @entry
    redirect_to entry_path(@entry), notice: '投票しました'
  end

  def unlike
    current_member.voted_entries.destroy(Entry.find params[:id])
    redirect_to voted_entries_path, notice: '投票を取り消しました'
  end

  def voted
    @entries = current_member.voted_entries.published.order('votes.created_at DESC').page(params[:page]).per(15)
  end

  private

  def entry_permit_params
    params.require(:entry).permit(:member_id, :title, :body, :posted_at, :status)
  end

end

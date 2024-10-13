class GroupschedulesController < ApplicationController
  def index
    @user = current_user
    @room = Room.find(params[:room_id])
  end

  def new
    @user = current_user
    @room = Room.find(params[:room_id])

    @ownplans = Ownplan.where(room_id: @room.id, target_week: nil)
    @targetweek = Ownplan.where(room_id: @room.id).where.not(target_week: nil)
    @target_week_dates = @targetweek.pluck(:target_week).map { |date| date.to_date }
		@groupschedule = Groupschedule.new
  end

  def create
    # ストロングパラメータを使用して、必要なデータを取得
    group_members = params[:group_members] || []
    selected_games = params[:selected_games] || []

    # デバッグ用に表示

    # データ処理...
  end

  private

  def group_schedule_params
    params.require(:group_schedule).permit(group_members: [], selected_games: [])
  end
end
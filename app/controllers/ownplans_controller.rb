class OwnplansController < ApplicationController
  before_action :set_weekplan, only: [:new, :create, :create_plan]

  def new
    @room = Room.find(params[:room_id])
    @user = current_user

    # target_weekにデータが存在しない場合、今日の日付で新しいOwnplanを作成
    @weekplan = Ownplan.where(room_id: @room.id).where.not(target_week: nil).first

    if @weekplan.nil?
      # target_weekがnilのレコードが見つからなかった場合、新しいレコードを作成
      @weekplan = Ownplan.new(target_week: Date.today, user_id: @user.id, room_id: @room.id, starter: 1)
      @weekplan.save
    end
    @ownplan = Ownplan.where(user_id: @user.id, room_id: @room.id).where(target_week: nil).first_or_initialize
    @ownplans = Ownplan.includes(:room)
  end

  def create
    @room = Room.find(params[:room_id])
    @user = current_user

    # target_weekにデータが存在するレコードを検索
    @weekplan = Ownplan.where(room_id: @room.id).where.not(target_week: nil).first

    if @weekplan
      # 既存のレコードが見つかった場合は更新する
      @weekplan.starter = 0
      if @weekplan.update(targetweek_params)
        Ownplan.where(room_id: @room.id, target_week: nil).destroy_all
        redirect_to new_room_user_ownplan_path(@room.id, @user.id), notice: '日付が更新されました。'
      else
        render :new # エラーメッセージなどがある場合は新規作成画面を再表示
      end
    else
      # 既存のレコードが見つからなかった場合は新規作成
      @weekplan = Ownplan.new(targetweek_params)
      if @weekplan.save

        redirect_to room_path(@room.id), notice: '日付が登録されました。'
      else
        render :new # エラーメッセージなどがある場合は新規作成画面を再表示
      end
    end
  end

  def create_plan
    @room = Room.find(params[:room_id])
    @user = current_user
    @ownplan = Ownplan.where(user_id: @user.id, room_id: @room.id).where(target_week: nil).first_or_initialize(ownplan_params)

    options = params[:options]
    if params[:options].present?
      @ownplan.day1 = options['1']
      @ownplan.day2 = options['2']
      @ownplan.day3 = options['3']
      @ownplan.day4 = options['4']
      @ownplan.day5 = options['5']
      @ownplan.day6 = options['6']
      @ownplan.day7 = options['7']
    end
    if @ownplan.save
      redirect_to room_path(@room.id), notice: '予定が登録されました。'
    else
      render :new, alert: '保存に失敗しました。'
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @user = current_user
    @ownplan = Ownplan.find(params[:id])
    @weekplan = Ownplan.where(room_id: @room.id).where.not(target_week: nil).first
    @schedule_datas =ScheduleData.where(room_id: @room.id)
    if @schedule_datas.present?
      @schedule_datas.each do |schedule_data|
        schedule_data.destroy
      end
    end
    if @ownplan.destroy
      redirect_to room_path(@room), notice: '予定が削除されました。'
    else
      render :new, alert: '予定の削除に失敗しました。'
    end
  end

  private

  def targetweek_params
    params.require(:ownplan).permit(:target_week).merge(user_id: @user.id, room_id: @room.id)
  end

  def ownplan_params
    params.require(:ownplan).permit(:frequency_id, :target_week, '1', '2', '3', '4', '5', '6', '7').merge(
      user_id: params[:user_id], room_id: params[:room_id]
    )
  end

  def set_weekplan
    @room = Room.find(params[:room_id])
    @user = current_user

    @weekplan = Ownplan.where(room_id: @room.id).where.not(target_week: nil).first

    return unless @weekplan.nil?

    # target_weekがnilのレコードが見つからなかった場合、新しいレコードを作成
    @weekplan = Ownplan.new(target_week: Date.today, user_id: @user.id, room_id: @room.id, starter: 1)
    @weekplan.save
  end
end

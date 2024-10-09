class OwnplansController < ApplicationController

	def new
		@room = Room.find(params[:room_id])
		@user = current_user
		
		# target_weekにデータが存在しない場合、今日の日付で新しいOwnplanを作成
		@ownplan = Ownplan.where(room_id: @room.id).where.not(target_week: nil).first
		
		if @ownplan.nil?
			# target_weekがnilのレコードが見つからなかった場合、新しいレコードを作成
			@ownplan = Ownplan.new(target_week: Date.today, user_id: @user.id, room_id: @room.id)
			@ownplan.save
		end
		
		@ownplans = Ownplan.includes(:room)
	end

	def create
		@room = Room.find(params[:room_id])
		@user = current_user
		
		# target_weekにデータが存在するレコードを検索
		@ownplan = Ownplan.find_by(room_id: @room.id).where.not(target_week: nil)

		if @ownplan
			# 既存のレコードが見つかった場合は更新する
			if @ownplan.update(ownplan_params)
				redirect_to room_path(@room.id), notice: '日付が更新されました。'
			else
				render :new # エラーメッセージなどがある場合は新規作成画面を再表示
			end
		else
			# 既存のレコードが見つからなかった場合は新規作成
			@ownplan = Ownplan.new(ownplan_params.merge(user_id: @user.id, room_id: @room.id))
			if @ownplan.save
				redirect_to room_path(@room.id), notice: '日付が登録されました。'
			else
				render :new # エラーメッセージなどがある場合は新規作成画面を再表示
			end
		end
	end
	
	private
	
	def ownplan_params
		params.require(:ownplan).permit(:target_week) # ここではtarget_weekだけを許可
	end

  private

  def ownplan_params
    params.require(:ownplan).permit(:target_week).merge(user_id: @user.id, room_id: @room.id)
  end
end

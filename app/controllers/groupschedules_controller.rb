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
	@target_week_dates = @targetweek.pluck(:target_week).map { |date| date.to_date}
end

end

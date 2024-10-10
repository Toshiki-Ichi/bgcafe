class GroupschedulesController < ApplicationController
def new
	@user = current_user
	@room = Room.find(params[:room_id])

end

end

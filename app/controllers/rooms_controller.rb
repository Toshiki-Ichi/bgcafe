class RoomsController < ApplicationController
	def index
		@rooms = Room.includes(:user)
	end

	def new
	end
end

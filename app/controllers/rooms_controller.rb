class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :show, :update]

  def index
    @rooms = Room.includes(user_rooms: :user) 
  end

  def new
    @room =Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
end

def destroy
end

def show
end

private

  def room_params
   params.require(:room).permit(:room_name,:orner,:image_rooms) 
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
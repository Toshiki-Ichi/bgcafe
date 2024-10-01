class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :show, :destroy]

  def index
    @rooms = Room.includes(user_rooms: :user).order(created_at: :desc)
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
  @room.destroy
  redirect_to rooms_path, notice: 'ルームが削除されました。'
end

def edit
end

def update
  room = Room.find(params[:id])
  room.update(room_params)
  redirect_to root_path
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
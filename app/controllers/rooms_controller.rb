class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_room, only: [:edit, :show, :destroy]
  before_action :redirect_root, only: [:edit,:update,:destroy]

  def index
    @rooms = Room.includes(user_rooms: :user).order(created_at: :desc)
  end

  def new
    @room =Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.creator = current_user
    if @room.save
      redirect_to root_path
    else
      render :new
    end
end

def edit
end

def update
  room = Room.find(params[:id])
  room.update(room_params)
  redirect_to room_path
end

def destroy
  @room.destroy
  redirect_to rooms_path, notice: 'ルームが削除されました。'
end

def show
  @user = current_user
end

private

  def room_params
   params.require(:room).permit(:room_name,:contact,:image_rooms) 
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def redirect_root 
    @room = Room.find(params[:id])
    unless @room.creator_id == current_user.id
    redirect_to root_path
    return
    end
  end
end

class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_room, only: [:edit, :show, :destroy]
  before_action :set_user, only: [:create, :show]
  before_action :redirect_root, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.includes(user_rooms: :user).order(created_at: :desc)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.creator = current_user

    if !@user.join1.nil? && !@user.join2.nil? && !@user.join3.nil?
      flash.now[:alert] = 'これ以上はルームを作成できません。'
      redirect_to root_path and return
      return
    end

    if @room.save
      if @user.join1.nil?
        @user.join1 = @room.id
      elsif @user.join2.nil?
        @user.join2 = @room.id
      else
        @user.join3 = @room.id
      end
      @user.save(validate: false)

      redirect_to root_path

    else
      redirect_to new_room_path
    end
  end

  def edit
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: 'ルームが削除されました。'
  end

  def show
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :contact, :image_rooms)
  end

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def redirect_root
    @room = Room.find(params[:id])
    return if @room.creator_id == current_user.id

    redirect_to root_path
    nil
  end
end

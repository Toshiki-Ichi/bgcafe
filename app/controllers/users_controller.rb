class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :check, :check_edit, :check_update,:clear_join]
  before_action :set_room, only: [:index ,:edit ,:update ,:show]
  before_action :redirect_if_not_logged_in

  def index
    @users = User.includes(:rooms, :my_image_attachment)
                 .where('join1 = :room_id OR join2 = :room_id OR join3 = :room_id', room_id: @room.id)
                 .select(:id, :nickname, :career_id, :likes, :weakness, :sns, :note, :join1, :join2, :join3)
    @users.each do |user|
      user.note = user.note.gsub(/\n/, '<br>') if user.note.present?
    end
    @game = @room.games.includes(:room).order(created_at: :desc)
  end

  def edit
  end

  def update
    room_id = params[:room_id].to_i
    unless @user.join1 == room_id || @user.join2 == room_id || @user.join3 == room_id

      if @user.join1.nil?
        @user.join1 = room_id
      elsif @user.join2.nil?
        @user.join2 = room_id
      elsif @user.join3.nil?
        @user.join3 = room_id
      else
        flash.now[:alert] = 'これ以上はルームに参加できません。'
        redirect_to root_path
        return
      end
    end
    if @user.update(user_params)
      redirect_to room_path(params[:room_id])
      nil
    else
      render :edit
    end
  end

  def show
  end

  def check
  end

  def check_edit
  end

  def check_update
    if @user.update(user_params)
      redirect_to check_user_path
      nil
    else
      render :check_edit
    end
  end

 
  def clear_join
    case params[:join_type]
    when 'join1'
      @user.update(join1: nil)
    when 'join2'
      @user.update(join2: nil)
    when 'join3'
      @user.update(join3: nil)
    end
    
    redirect_to check_user_path(current_user), notice: '参加を解除しました。'
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :career_id, :likes, :weakness, :sns, :note, :my_image)
  end

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def redirect_if_not_logged_in
    return if user_signed_in?

    redirect_to root_path
  end
end

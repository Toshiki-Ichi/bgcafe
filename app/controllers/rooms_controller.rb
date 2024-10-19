class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_room, only: [:edit,:updata, :show, :destroy]
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
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    room_id = @room.id
      User.find_each do |user|
      # join1、join2、join3のいずれかがルームIDと一致する場合、nilに設定
      user.update(join1: nil) if user.join1 == room_id
      user.update(join2: nil) if user.join2 == room_id
      user.update(join3: nil) if user.join3 == room_id
    end
    redirect_to rooms_path, notice: 'ルームが削除されました。'
  end

  def enter
    room = Room.find_by(id: params[:room_id]) # IDからルームを取得

    # ルームが存在しない場合の処理
    unless room
      render json: { success: false, message: "ルームが見つかりません" }, status: :not_found
      return
    end

    # パスワードの認証
    if room.authenticate(params[:password]) # authenticateメソッドでパスワードチェック
      render json: { success: true }
    else
      render json: { success: false, message: "無効なパスワードです" }, status: :unauthorized
    end
  end


  def show
    @targetweek = Ownplan.where(room_id: @room.id).where.not(target_week: nil)
    @target_week_dates = @targetweek.pluck(:target_week).map { |date| date.to_date }
    @groupschedules = Groupschedule.where(room_id: @room.id)
    @planning_games = ScheduleData.where(room_id: @room.id)
  end

  private

  def room_params
    params.require(:room).permit(:image_rooms, :room_name, :contact, :summary, :password, :password_confirmation)
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
  end
end

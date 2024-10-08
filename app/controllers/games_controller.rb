class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_root, only: [:edit,:update,:destroy]
  def index
    @user = User.find(params[:user_id])
    @room = Room.find(params[:room_id])
    @games = @room.games.includes(:room).order(created_at: :desc) 
    @games.each do |game|
      game.rule = game.rule.gsub(/\n/, '<br>') if game.rule.present?
    end
  end

	def new
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
		@game =Game.new
	end

	def create
  
		@game = Game.new(game_params)
    @game.room_id = params[:room_id]
    @game.user_id = current_user.id 
    if @game.save
      redirect_to room_path(params[:room_id])
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id])
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])

  end
  
  def update

  @game = Game.find(params[:id]) 
  @room = @game.room 
  @user = @game.user 
  
  if @game.update(game_params)
    redirect_to room_user_games_path(@room, @user) 
  else
    render :edit 
  end
end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  redirect_to room_user_games_path, notice: 'ルームが削除されました。'
  end

  def show
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id]) 
    @games = @room.games.includes(:room)
                .where(user_id: @user.id)
                .order(created_at: :desc)
    @games.each do |game|
      game.rule = game.rule.gsub(/\n/, '<br>') if game.rule.present? 
    end
  end
private

  def game_params
   params.require(:game).permit(:game_name,:rule,:image_games) 
  end

	def redirect_if_not_logged_in
    unless user_signed_in? 
      redirect_to root_path 
    end
  end

  def redirect_root 
    @game = Game.find(params[:id])
    unless @game.user_id == current_user.id
    redirect_to root_path
    return
    end
  end
end

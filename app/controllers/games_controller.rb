class GamesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @room = Room.find(params[:room_id])
    @games = @room.games.includes(:room).order(created_at: :desc) # room に紐づく games を取得
    @games.each do |game|
      game.rule = game.rule.gsub(/\n/, '<br>') if game.rule.present? # 改行を <br> に変換
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
    game = Game.find(params[:id])
    game.update(game_params)
    redirect_to room_user_games_path
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  redirect_to room_user_games_path, notice: 'ルームが削除されました。'
  end

  def show
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id]) # 特定のユーザーを取得

    @games = @room.games.includes(:room)
                .where(user_id: @user.id) # 特定のユーザーに紐づいたゲームを取得
                .order(created_at: :desc)
    @games.each do |game|
      game.rule = game.rule.gsub(/\n/, '<br>') if game.rule.present? # 改行を <br> に変換
    end
  end
private

  def game_params
   params.require(:game).permit(:game_name,:rule,:image_games) 
  end
end

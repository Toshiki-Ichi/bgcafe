class GamesController < ApplicationController

  def index
    @room = Room.find(params[:room_id])
    @games = Game.includes(:room).order(created_at: :desc)
    @games.each do |game|
      game.rule = game.rule.gsub(/\n/, '<br>') if game.rule.present? # 改行を <br> に変換
    end
  end

	def new
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
private

  def game_params
   params.require(:game).permit(:game_name,:rule,:image_games) 
  end
end

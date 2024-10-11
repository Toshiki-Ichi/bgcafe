class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_root, only: [:edit, :update, :destroy]
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
    @game = Game.new
  end

  def create
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
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

  def played_check
    @games = Game.includes(:room)
    @user = current_user
  end

  def played_update
    selected_game_ids = params[:selected_games] # 選択されたゲームのIDを取得

    # 各ゲームのplayedカラムを更新
    selected_game_ids.each do |game_id|
      game = Game.find(game_id) # ゲームを取得
      # playedカラムに既存のIDを取得
      existing_played_ids = game.played.present? ? game.played.split(',') : []

      # ユーザーIDを追加し、重複を排除
      updated_played_ids = (existing_played_ids + [current_user.id.to_s]).uniq

      # 各ゲームのplayedカラムを更新
      unless game.update(played: updated_played_ids.join(','))
        # 更新に失敗した場合はエラーをログに記録
        Rails.logger.error("Failed to update game #{game.id}: #{game.errors.full_messages.join(', ')}")
      end
    end

    # 保存が成功した場合
    redirect_to room_path, notice: 'ゲーム情報が更新されました'
  rescue ActiveRecord::RecordNotFound
    # ゲームが見つからなかった場合の処理
    flash[:alert] = '選択されたゲームが見つかりませんでした。'
    redirect_to room_path
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
    params.require(:game).permit(:image_games, :game_name, :capacity_id, :require_time_id, :rule)
  end

  def redirect_if_not_logged_in
    return if user_signed_in?

    redirect_to root_path
  end

  def redirect_root
    @game = Game.find(params[:id])
    return if @game.user_id == current_user.id

    redirect_to root_path
    nil
  end
end

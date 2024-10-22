class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_root, only: [:edit, :update, :destroy]
  before_action :reject_non_member
  before_action :set_room, only: [:index,:new,:create, :edit, :show,:played_check,:played_update]
  before_action :set_user, only: [:index,:new ,:create ,:edit, :show]
  before_action :set_game, only: [:edit ,:update , :destroy]

  def index
    @games = @room.games.includes(:room).order(created_at: :desc)
    @games.each do |game|
      game.rule = game.rule.gsub(/\n/, '<br>') if game.rule.present?
    end
  end

  def new
    @game = Game.new
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
  end

  def update
    @room = @game.room
    @user = @game.user

    if @game.update(game_params)
      redirect_to room_user_games_path(@room, @user)
    else
      render :edit
    end
  end

  def played_check
    @games = Game.where(room_id: @room.id).order(created_at: :desc)
    @user = current_user
  end

  def played_update
    @user = current_user
    selected_game_ids = params[:selected_games] || []
    games = Game.where(room_id: @room.id)

    # 取得したゲームの中で選択されていないゲームのplayedからユーザーIDを削除
    games.each do |game|
      existing_played_ids = game.played.present? ? game.played.split(',') : []
    
      unless selected_game_ids.include?(game.id.to_s)
        # 現在のユーザーIDを削除
        existing_played_ids.delete(current_user.id.to_s)
    
        # playedを更新する
        unless existing_played_ids.empty?
          game.update(played: existing_played_ids.join(','))
        else
          # playedが空になる場合、空文字に設定する
          game.update(played: nil)
        end
      end
    end

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
    @game.destroy
    redirect_to room_user_games_path, notice: 'ルームが削除されました。'
  end

  def show
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

  def reject_non_member
    @room = Room.find(params[:room_id])
    user_joins = [current_user.join1, current_user.join2, current_user.join3]
    unless user_joins.include?(@room.id)
      redirect_to root_path, alert: 'このルームにはアクセスできません。'
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_game
    @game = Game.find(params[:id])
  end
end

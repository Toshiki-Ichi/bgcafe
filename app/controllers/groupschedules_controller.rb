class GroupschedulesController < ApplicationController
  def index
    @user = current_user
    @room = Room.find(params[:room_id])
    @user_count = User.where("join1 = ? OR join2 = ? OR join3 = ?", @room.id, @room.id, @room.id).count
    @groupschedules = Groupschedule.where(room_id: @room.id)
  end

  def new
    @user = current_user
    @room = Room.find(params[:room_id])

    @ownplans = Ownplan.where(room_id: @room.id, target_week: nil)
    @targetweek = Ownplan.where(room_id: @room.id).where.not(target_week: nil)
    @target_week_dates = @targetweek.pluck(:target_week).map { |date| date.to_date }
    @groupschedules =Groupschedule.new

  end

  def create
    @user = current_user
    @room = Room.find(params[:room_id])

    #日中のグループを保存する記述
    errors = []

    def save_groupschedule(time_key, property_suffix)
      (1..7).each do |n|
        member_ids = params.dig(:groupschedules, "day#{n}_#{time_key}", :member_ids) || []
    
        # インスタンス変数を動的に設定
        groupschedule = instance_variable_set("@groupschedule#{n}", Groupschedule.new)
        groupschedule.day = n
        
        # メンバーを3つまで設定
        member_ids.each_with_index do |member_id, j|
          if j < 3
            # sendメソッドを使って動的にプロパティに値を代入
            groupschedule.send("group#{j+1}_#{property_suffix}=", member_id)
          else
            errors << "#{time_key}で選択できるのは3つのグループまでです。"
            break
          end
        end
      end
    end
    
    # 日中のグループを保存する
    save_groupschedule("daytime", "daytime")
    
    # 20pmのグループを保存する
    save_groupschedule("20pm", "20pm")
    
    # 21pmのグループを保存する
    save_groupschedule("21pm", "21pm")
    
    # 22pmのグループを保存する
    save_groupschedule("22pm", "22pm")
    
    if errors.any?
      render new: { errors: errors }, status: :unprocessable_entity
      return
    end    
  
    # @groupschedule1〜@groupschedule7を保存する
    (1..7).each do |n|
      groupschedule = instance_variable_get("@groupschedule#{n}")
      
      unless groupschedule.valid?  # バリデーションチェック
        errors << "グループ#{n}の保存に失敗しました。"
      end
    end
  
    # 成功した場合の保存処理
    if errors.empty?
      (1..7).each do |n|
        groupschedule = instance_variable_get("@groupschedule#{n}")
        groupschedule.room_id = @room.id
        groupschedule.save
      end
      redirect_to room_path(@room), notice: "グループが正常に保存されました。"
    else
      render new: { errors: errors }, status: :unprocessable_entity
    end
  end
  

    def edit
      @user = current_user
      @room = Room.find(params[:room_id])
      @schedules = Groupschedule.where(room_id: @room.id)
      @targetweek = Ownplan.where(room_id: @room.id).where.not(target_week: nil)
      @target_week_dates = @targetweek.pluck(:target_week).map { |date| date.to_date }
    end

    def update
      @user = current_user
      @room = Room.find(params[:room_id])
    
      # 各日ごとのスケジュール処理
      (1..7).each do |day|
        # 既存のレコードがあれば取得し、なければ新しいレコードを作成
        schedule = ScheduleData.find_or_initialize_by(room_id: @room.id, day: day)
    
        # 変数を動的に生成するためのインスタンス変数を設定
        instance_variable_set("@group_schedule_game#{day}", schedule)
    
        # 振り分けるキーを生成
        keys = (1..3).flat_map do |group|
          [
            "group#{group}_daytime_day#{day}",
            "group#{group}_20pm_day#{day}",
            "group#{group}_21pm_day#{day}",
            "group#{group}_22pm_day#{day}"
          ]
        end
    
        # ゲームの設定処理
        patterns = ['daytime', '20pm', '21pm', '22pm']
    
        patterns.each do |pattern|
          (1..3).each do |group|
            game_param_key = "group#{group}_#{pattern}_day#{day}"
    
            if params[game_param_key].present?
              # Gameが存在するか確認
              game = Game.find_by(id: params[game_param_key])
    
              if game
                # Gameが存在する場合は、ScheduleDataに設定
                schedule.send("group#{group}_#{pattern}_game=", game)
              else
                Rails.logger.error("Game with ID #{params[game_param_key]} does not exist.")
                flash[:error] = "指定されたゲームが存在しません: ID #{params[game_param_key]}"
              end
            end
          end
        end
      end  # 各日ごとのスケジュール処理の終了
    
      # グループ数と日数の設定
      groups = ['group1', 'group2', 'group3']
      days = (1..7).to_a
    
    
      def set_group_schedule_games(day, group_times)
        group_times.each do |time|
          @group_schedule_game1.send("group1_#{time}_game=", params["group1_#{time}_day#{day}"])
          @group_schedule_game1.send("group2_#{time}_game=", params["group2_#{time}_day#{day}"])
          @group_schedule_game1.send("group3_#{time}_game=", params["group3_#{time}_day#{day}"])
          @group_schedule_game1.user_id = @user.id
          @group_schedule_game1.groupschedule_id = Groupschedule.find_by(room_id: @room.id, day: day).id
          @group_schedule_game1.game_id = Game.where(room_id: @room.id).sample.id
          
          unless @group_schedule_game1.save
            # エラーメッセージを表示
            puts @group_schedule_game1.errors.full_messages
          end
        end
      end
      
      (1..7).each do |day|
        set_group_schedule_games(day, ['daytime', '20pm', '21pm', '22pm'])
      end

end  # updateメソッドの終了
    
    
 
  private

  def group_schedule_params
    params.require(:groupschedules).permit(
    day1_daytime: [:member_ids],day2_daytime: [:member_ids],day3_daytime: [:member_ids],day4_daytime: [:member_ids],day5_daytime: [:member_ids],day6_daytime: [:member_ids],day7_daytime: [:member_ids],
    day1_20pm: [:member_ids],day2_20pm: [:member_ids],day3_20pm: [:member_ids],day4_20pm: [:member_ids],day5_20pm: [:member_ids],day6_20pm: [:member_ids],day7_20pm: [:member_ids],
    day1_21pm: [:member_ids],day2_21pm: [:member_ids],day3_21pm: [:member_ids],day4_21pm: [:member_ids],day5_21pm: [:member_ids],day6_21pm: [:member_ids],day7_21pm: [:member_ids],
    day1_22pm: [:member_ids],day2_22pm: [:member_ids],day3_22pm: [:member_ids],day4_22pm: [:member_ids],day5_22pm: [:member_ids],day6_22pm: [:member_ids],day7_22pm: [:member_ids]    
    ).merge(user_id: params[:user_id], room_id: params[:room_id])
  end

  def schedule_params
    params.permit(
      :room_id,
      :user_id,
      :game_id,
      (1..7).flat_map do |day|
        [
          "group1_daytime_day#{day}", "group1_20pm_day#{day}", "group1_21pm_day#{day}", "group1_22pm_day#{day}",
          "group2_daytime_day#{day}", "group2_20pm_day#{day}", "group2_21pm_day#{day}", "group2_22pm_day#{day}",
          "group3_daytime_day#{day}", "group3_20pm_day#{day}", "group3_21pm_day#{day}", "group3_22pm_day#{day}"
        ]
      end
    )
    end
end
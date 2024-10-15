class GroupschedulesController < ApplicationController
  def index
    @user = current_user
    @room = Room.find(params[:room_id])
    @user_count = User.where("join1 = ? OR join2 = ? OR join3 = ?", @room.id, @room.id, @room.id).count
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
      @schedules = Groupschedule.all
      @targetweek = Ownplan.where(room_id: @room.id).where.not(target_week: nil)
      @target_week_dates = @targetweek.pluck(:target_week).map { |date| date.to_date }
    end

  private

  def group_schedule_params
    params.require(:groupschedules).permit(
    day1_daytime: [:member_ids],day2_daytime: [:member_ids],day3_daytime: [:member_ids],day4_daytime: [:member_ids],day5_daytime: [:member_ids],day6_daytime: [:member_ids],day7_daytime: [:member_ids],
    day1_20pm: [:member_ids],day2_20pm: [:member_ids],day3_20pm: [:member_ids],day4_20pm: [:member_ids],day5_20pm: [:member_ids],day6_20pm: [:member_ids],day7_20pm: [:member_ids],
    day1_21pm: [:member_ids],day2_21pm: [:member_ids],day3_21pm: [:member_ids],day4_21pm: [:member_ids],day5_21pm: [:member_ids],day6_21pm: [:member_ids],day7_21pm: [:member_ids],
    day1_22pm: [:member_ids],day2_22pm: [:member_ids],day3_22pm: [:member_ids],day4_22pm: [:member_ids],day5_22pm: [:member_ids],day6_22pm: [:member_ids],day7_22pm: [:member_ids]    
    ).merge(user_id: params[:user_id], room_id: params[:room_id])
  end
end
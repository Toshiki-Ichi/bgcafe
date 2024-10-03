class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update]

	def index
		@room = Room.find(params[:room_id])
		@users = User.includes(:rooms, :my_image_attachment).select(:id, :nickname, :career_id, :likes, :weakness, :sns, :note, :join1, :join2, :join3)
		@users.each do |user|
      user.note = user.note.gsub(/\n/, '<br>') if user.note.present? # 改行を <br> に変換
    end
	end

	def edit
		@room = Room.find(params[:room_id])
	end
	
	def update
		 room_id = params[:room_id].to_i
		 unless @user.join1 == room_id || @user.join2 == room_id || @user.join3 == room_id
		 if @user.join1.nil?
			 @user.join1 = room_id  # join1 が nil の場合は room_id を設定
		 elsif @user.join2.nil?
			 @user.join2 = room_id  # join2 が nil の場合は room_id を設定
		 elsif @user.join3.nil?
			 @user.join3 = room_id  # join3 が nil の場合は room_id を設定
		 else
			 flash.now[:alert] = "これ以上はルームに参加できません。"  # 参加できない場合のメッセージを設定
			 redirect_to root_path
		 end
		end
		if @user.update(user_params)  # ユーザーの更新を実行
			redirect_to room_path(params[:room_id])
		else
			render :edit  # 更新が失敗した場合は edit ビューを再表示
		end
	end



	private

  def user_params
	 params.require(:user).permit(:nickname, :career_id, :likes, :weakness, :sns, :note,:join1,:join2,:join3,:my_image)

  end

  def set_user
    @user = current_user
  end
end

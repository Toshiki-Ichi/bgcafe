class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update]

	def edit
		@room = Room.find(params[:room_id])
	end
	
	def update
		 room_id = params[:room_id]  # 遷移元の room_id を取得
  
		 # join1, join2, join3 に対するロジック
		 if @user.join1.nil?
			 @user.join1 = room_id  # join1 が nil の場合は room_id を設定
		 elsif @user.join2.nil?
			 @user.join2 = room_id  # join2 が nil の場合は room_id を設定
		 elsif @user.join3.nil?
			 @user.join3 = room_id  # join3 が nil の場合は room_id を設定
		 else
			 flash.now[:alert] = "これ以上はルームに参加できません。"  # 参加できない場合のメッセージを設定
			 redirect_to root_path
			 return  # 処理を終了
		 end

		if @user.update(user_params)  # ユーザーの更新を実行
			redirect_to room_path(params[:room_id]), notice: 'ユーザーが更新されました。'  # 正しいリダイレクト
		else
			render :edit  # 更新が失敗した場合は edit ビューを再表示
		end
	end


	private

  def user_params
	 params.require(:user).permit(:nickname, :career_id, :likes, :weakness, :sns, :note, :join1, :join2, :join3)

  end

  def set_user
    @user = current_user
  end
end

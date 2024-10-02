class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update]

	def edit
	end
	
	def update
		@user.update(user_params)
		redirect_to room_path
	end

	private

  def user_params
	 params.require(:user).permit(:nickname, :career_id, :likes, :weakness, :sns, :note, :join1, :join2, :join3)

  end

  def set_user
    @user = current_user
  end
end

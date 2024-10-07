require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @game = FactoryBot.build(:game, user_id: @user.id, room_id: @room.id)
  end

  describe 'ルーム新規作成' do
    context 'ゲームの新規登録ができるとき' do
      it 'game_name,rule,image_gamesが存在すれば登録できる' do
      expect(@game).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'game_nameが空では登録できない' do
      @game.game_name =''
      @game.valid?
      expect(@game.errors.full_messages). to include("Game name は空白では登録できません")
      end
      it 'ruleが空では登録できない' do
      @game.rule =''
      @game.valid?
      expect(@game.errors.full_messages). to include("Rule は空白では登録できません")
      end
      it 'image_gamesが空では登録できない' do
        @game.image_games =nil
        @game.valid?
        expect(@game.errors.full_messages). to include("Image games は必須です")
        end
        it 'user_idが紐づいている必要がある' do
          @game.user_id = nil
          @game.valid?
          expect(@game.errors.full_messages). to include("User が必要です")
         end
         it 'room_idが紐づいている必要がある' do
          @game.room_id = nil
          @game.valid?
          expect(@game.errors.full_messages). to include("Room が必要です")
         end
    end
  end
end

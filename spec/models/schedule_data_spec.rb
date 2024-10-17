require 'rails_helper'

RSpec.describe ScheduleData, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @game = FactoryBot.create(:game, user_id: @user.id, room_id: @room.id)
    @groupschedule = FactoryBot.create(:groupschedule, room_id: @room.id)
    @schedule_data = FactoryBot.build(:schedule_data,groupschedule_id: @groupschedule.id,room: @room,user_id: @user.id,game_id: @game.id,)
  end

  describe 'ゲームの予定を登録' do
    context 'ゲームを登録できるとき' do
      it 'dayが存在すれば登録できる' do
        expect(@schedule_data).to be_valid
      end
    end
    context '予定を登録できないとき' do
      it 'dayが空では登録できない' do
        @schedule_data.day = ''
        @schedule_data.valid?
        expect(@schedule_data.errors.full_messages).to include("Day can't be blank")
      end
      it 'dayには1~7の数字以外は登録できない' do
        @schedule_data.day = loop do
          number = rand(0..100) 
          break number if number < 1 || number > 7 
        end
        @schedule_data.valid?
        expect(@schedule_data.errors.full_messages).to include( "Day は1から7の間である必要があります")
      end
      it 'room_idが紐づいている必要がある' do
        @schedule_data.room_id = nil
        @schedule_data.valid?
        expect(@schedule_data.errors.full_messages).to include("Room can't be blank")
      end
    end
  end
end

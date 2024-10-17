require 'rails_helper'

RSpec.describe Groupschedule, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @groupschedule = FactoryBot.build(:groupschedule , room_id: @room.id)
  end

  describe 'ルームの予定の登録' do
    context '予定を登録できるとき' do
      it 'dayが存在すれば登録できる' do
        expect(@groupschedule).to be_valid
      end
    end
    context '予定を登録できないとき' do
      it 'dayが空では登録できない' do
        @groupschedule.day = ''
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("Day can't be blank")
      end
      it 'dayには1~7の数字以外は登録できない' do
        @groupschedule.day = loop do
          number = rand(0..100) 
          break number if number < 1 || number > 7 
        end
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include( "Day は1から7の間である必要があります")
      end
      it 'room_idが紐づいている必要がある' do
        @groupschedule.room_id = nil
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("Room can't be blank")
      end
    end
  end
end

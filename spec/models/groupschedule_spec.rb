require 'rails_helper'

RSpec.describe Groupschedule, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @groupschedule = FactoryBot.build(:groupschedule , room_id: @room.id)
  end

  describe 'ルームの予定の登録' do
    context '予定を登録できるとき' do
      it 'dayが存在すれば登録できる(group1,2,3はnilでも構わない)' do
        expect(@groupschedule).to be_valid
      end
      it '違う時間帯であれば同じユーザーは登録できる' do
        @groupschedule.group1_daytime = '1'
        @groupschedule.group1_20pm = '1'
        @groupschedule.group1_21pm = '1'
        @groupschedule.group1_22pm = '1'
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
      it 'daytimeの違うグループに同じユーザーは登録できない' do
        @groupschedule.group1_daytime = '1'
        @groupschedule.group2_daytime = '1'
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("同じ時間に重複したユーザーがあります")
      end
      it '20pmの違うグループに同じユーザーは登録できない' do
        @groupschedule.group1_20pm = '1'
        @groupschedule.group2_20pm = '1'
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("同じ時間に重複したユーザーがあります")
      end
      it '21pmの違うグループに同じユーザーは登録できない' do
        @groupschedule.group1_21pm = '1'
        @groupschedule.group2_21pm = '1'
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("同じ時間に重複したユーザーがあります")
      end
      it '22pmの違うグループに同じユーザーは登録できない' do
        @groupschedule.group1_22pm = '1'
        @groupschedule.group2_22pm = '1'
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("同じ時間に重複したユーザーがあります")
      end
      it 'room_idが紐づいている必要がある' do
        @groupschedule.room_id = nil
        @groupschedule.valid?
        expect(@groupschedule.errors.full_messages).to include("Room can't be blank")
      end
    end
  end
end

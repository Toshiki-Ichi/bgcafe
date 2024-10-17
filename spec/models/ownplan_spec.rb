require 'rails_helper'

RSpec.describe Ownplan, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @ownplan = FactoryBot.build(:ownplan ,user_id: @user.id, room_id: @room.id)
  end

  describe '個人予定の登録' do
    context '予定を登録できるとき' do
      it 'day1~7,frequency_idが存在すれば登録できる' do
        expect(@ownplan).to be_valid
      end
    end
    context '予定を登録できないとき' do
      it 'day1が空では登録できない' do
        @ownplan.day1 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day1 はどれかを選択してください')
      end
      it 'day1は1~9以外の文字列は登録できない' do
        @ownplan.day1 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day1 は無効な値です')
      end
      it 'day2が空では登録できない' do
        @ownplan.day2 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day2 はどれかを選択してください')
      end
      it 'day2は1~9以外の文字列は登録できない' do
        @ownplan.day2 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day2 は無効な値です')
      end
      it 'day3が空では登録できない' do
        @ownplan.day3 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day3 はどれかを選択してください')
      end
      it 'day3は1~9以外の文字列は登録できない' do
        @ownplan.day3 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day3 は無効な値です')
      end
      it 'day4が空では登録できない' do
        @ownplan.day4 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day4 はどれかを選択してください')
      end
      it 'day4は1~9以外の文字列は登録できない' do
        @ownplan.day4 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day4 は無効な値です')
      end
      it 'day5が空では登録できない' do
        @ownplan.day5 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day5 はどれかを選択してください')
      end
      it 'day5は1~9以外の文字列は登録できない' do
        @ownplan.day5 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day5 は無効な値です')
      end
      it 'day6が空では登録できない' do
        @ownplan.day6 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day6 はどれかを選択してください')
      end
      it 'day6は1~9以外の文字列は登録できない' do
        @ownplan.day6 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day6 は無効な値です')
      end
      it 'day7が空では登録できない' do
        @ownplan.day7 = ''
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day7 はどれかを選択してください')
      end
      it 'day3は1~9以外の文字列は登録できない' do
        @ownplan.day7 = ('a'..'z').to_a.sample + ('A'..'Z').to_a.sample
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Day7 は無効な値です')
      end
      it 'frequency_idが0では登録できない' do
        @ownplan.frequency_id = 0
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Frequency は --- 以外を選択してください。')
      end
      it 'user_idが紐づいている必要がある' do
        @ownplan.user_id = nil
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('User must exist')
      end
      it 'room_idが紐づいている必要がある' do
        @ownplan.room_id = nil
        @ownplan.valid?
        expect(@ownplan.errors.full_messages).to include('Room must exist')
      end
    end
  end
end

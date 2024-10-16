require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @creator = FactoryBot.create(:user)
    @room = FactoryBot.build(:room, creator_id: @creator.id)
  end

  describe 'ルーム新規作成' do
    context '新規登録できるとき' do
      it 'room_name,contact,creator_id,image_roomsが存在すれば登録できる' do
        expect(@room).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'room_nameが空では登録できない' do
        @room.room_name = ''
        @room.valid?
        expect(@room.errors.full_messages).to include('Room name は空白では登録できません')
      end
      it 'contactが空では登録できない' do
        @room.contact = ''
        @room.valid?
        expect(@room.errors.full_messages).to include('Contact は空白では登録できません')
      end
      it 'image_roomsが空では登録できない' do
        @room.image_rooms = nil
        @room.valid?
        expect(@room.errors.full_messages).to include('Image rooms は必須です')
      end
      it 'creator_idが紐づいている必要がある' do
        @room.creator_id = nil
        @room.valid?
        expect(@room.errors.full_messages).to include("Creator can't be blank")
      end
    end
  end
end

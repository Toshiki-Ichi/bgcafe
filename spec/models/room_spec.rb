require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @creator = FactoryBot.create(:user)
    @room = FactoryBot.build(:room, creator_id: @creator.id)
  end

  describe 'ルーム新規作成' do
    context '新規登録できるとき' do
      it 'room_name,contact,creator_id,image_rooms,summary,password,password_confirmationが存在すれば登録できる' do
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
      it 'passwordが空では登録できない' do
        @room.password = nil
        @room.valid?
        expect(@room.errors.full_messages).to include("Password は必須です")
      end
      it 'passwordは6文字未満では登録できない' do
        @room.password = "123ab"
        @room.valid?
        expect(@room.errors.full_messages).to include("Password は6文字以上である必要があります")
      end
      it 'passwordは小文字英数字がないと登録できない' do
        @room.password = "123456"
        @room.valid?
        expect(@room.errors.full_messages).to include("Password は小文字の英字と数字を含む必要があります")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @room.password = '123456abc'
        @room.password_confirmation = '1234567ab'
        @room.valid?
        expect(@room.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'creator_idが紐づいている必要がある' do
        @room.creator_id = nil
        @room.valid?
        expect(@room.errors.full_messages).to include("Creator must exist")
      end
    end
  end
end

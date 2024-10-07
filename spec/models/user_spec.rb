require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
      @user.nickname =''
      @user.valid?
      expect(@user.errors.full_messages). to include("Nickname は必須です")
      end
      it 'emailが空では登録できない' do
      @user.email =''
      @user.valid?
      expect(@user.errors.full_messages). to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
      @user.password =''
      @user.valid?
      expect(@user.errors.full_messages). to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages). to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do  

      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
      end  
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
      @user.password ='test'
      @user.password_confirmation ='test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
      @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
    end
  end


  describe 'ユーザー情報更新(メンバー登録)' do
    context 'メンバー登録できるとき' do
      it 'career_idが1以外でlikesとweakness、noteが存在していれば登録できる' do
       expect(@user).to be_valid
       end
    end

    context 'メンバー登録できないとき' do
      it 'my_imageが空では登録できない' do
        @user.my_image = nil
        @user.valid?(:update)  
        expect(@user.errors.full_messages).to include("My image は必須です")
      end
      it 'career_idが1では登録できない' do
        @user.career_id = 1
        @user.valid?(:update) 
        expect(@user.errors.full_messages).to include("Career は --- 以外を選択してください。")
      end
  
      it 'likesが空では登録できない' do
        @user.likes = ''
        @user.valid?(:update)
        expect(@user.errors.full_messages).to include("Likes は空白では登録できません")
      end
  
      it 'weaknessが空では登録できない' do
        @user.weakness = ''
        @user.valid?(:update)
        expect(@user.errors.full_messages).to include("Weakness は空白では登録できません")
      end
  
      it 'noteが空では登録できない' do
        @user.note = ''
        @user.valid?(:update)
        expect(@user.errors.full_messages).to include("Note は空白では登録できません")
      end
  
    end
  end
end

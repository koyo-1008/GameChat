require 'rails_helper'

describe User do
  describe '#create' do
    subject do
      user.valid?
      user
    end

    context "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      let(:user) { build(:user) }
      it { expect(subject.errors.full_messages).to eq([]) }
    end

    context " nicknameが空の場合" do
      let(:user) { build(:user, nickname: nil) }
      it { expect(subject.errors[:nickname]).to include("can't be blank") }
    end

    context "emailが空の場合" do
      let(:user) { build(:user, email: nil) }
      it { expect(subject.errors[:email]).to include("can't be blank") }
    end

    context "passwordが空の場合" do
      let(:user) { build(:user, password: nil) }
      it { expect(subject.errors[:password]).to include("can't be blank") }
    end

    context "password_confirmationが空の場合" do
      let(:user) { build(:user, password_confirmation: "") }
      it { expect(subject.errors[:password_confirmation]).to include("doesn't match Password") }
    end

    context "nicknameが6文字以上では登録できること " do
      let(:user) { build(:user, nickname: "aaaaaa") }
      it { expect(subject.errors.full_messages).to eq([]) }
    end

    context " 重複したemailが存在する場合は登録できないこと " do
      before { create(:user, email: 'test@example.com') }
      let(:user) { build(:user, email: 'test@example.com') }
      it { expect(subject.errors[:email]).to include("has already been taken") }
    end

    context " passwordが8文字以上であれば登録できること " do
      let(:user) { build(:user, password: "00000000", password_confirmation: "00000000") }
      it { expect(subject.errors.full_messages).to eq([]) }
    end

    context " passwordが5文字以下であれば登録できないこと " do
      let(:user) { build(:user, password: "00000", password_confirmation: "00000") }
      it { expect(subject.errors[:password]).to include("is too short (minimum is 6 characters)") }
    end
  end
end
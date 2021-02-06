require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe 'validations' do
    subject do
      channel.valid?
      channel
    end

    context 'valid' do
      let(:channel) { build(:channel) }

      it { expect(subject.errors.keys).to eq([]) }
    end

    context 'チャンネルの名前が空の時' do
      let(:channel) { build(:channel, name: '') }

      it { expect(subject.errors.keys).to contain_exactly(:name) }
    end
  end
end


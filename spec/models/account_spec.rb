require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'account' do
    let(:user){build :user}
    
    let (:account){build :account,user:user }
    let(:account1){build :account,user:user}
    let(:account2){build :account,name:nil,user:user}

    it 'should valid account' do
      expect(account.valid?).to eq(true)
    end

    it 'should valid account' do
      expect(account2.valid?).to eq(false)
    end

    it 'name should be equal' do
      expect(account1.name).to eq("dhgggg")
    end

    it 'without name' do
      expect(account2.name).to eq(nil)
    end


  end
end

require 'rails_helper'

RSpec.describe Community, type: :model do
  context 'community should be ' do
    let(:community1) {build :community}
    let(:community2) {build :community,name:nil}

    it 'valid community' do
      expect(community1.valid?).to eq(true)
    end

    it 'Invalid community' do
      expect(community2.valid?).to eq(false)
    end
    
    it 'name is nil' do
      expect(community2.name).to eq(nil)
    end

  end
end

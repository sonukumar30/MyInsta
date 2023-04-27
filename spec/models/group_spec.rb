require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'group' do
    context 'group should be ' do
      let(:community) {build :community}
      let(:group){ build:group, community:community}
      let(:group1){ build:group,name:nil, community:community}  
  
      it 'valid community' do
        expect(group.valid?).to eq(true)
      end
  
      it 'Invalid community' do
        expect(group1.valid?).to eq(false)
      end
      
      it 'name is nil' do
        expect(group1.name).to eq(nil)
      end
  
    end
  end
end

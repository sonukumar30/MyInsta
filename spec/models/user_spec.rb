require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user1) {build :user}
    let(:user2) {build :user,email:'email'}
    let(:user3) {build :user,password:''}

    it 'should be valid user' do
      expect(user1.valid?).to eq(true)
    end

    it 'should be Invalid user' do
      expect(user2.valid?).to eq(false)
    end
  
    it 'should be Invalid user' do
      expect(user3.valid?).to eq(false)
    end

  end

  describe "after_create" do
    let(:user) { create(:user) }

    it "creates an account for the user" do
      expect(user.account.name) == user.email.split('@').first.upcase
    end
   
  end
end

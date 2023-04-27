require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'post' do
    let(:user){build :user}
    
    let(:post1) {build :post,user:user}
    let(:post3) {build :post}
    let(:post2) {build :post,title:'df',user:user}
    let(:post4) {build :post,description:'df',user:user}
    let(:post5) {build :post,keyword:'df',user:user}


    it 'valid post' do
      expect(post1.valid?).to eq(true)
    end

    it 'Invalid post bcz validations not achieved' do
      expect(post2.valid?).to eq(false)
    end

    it 'Invalid post' do
      expect(post3.valid?).to eq(false)
    end

    it 'Invalid post ' do
      expect(post4.valid?).to eq(false)
    end

    it 'Invalid post ' do
      expect(post5.valid?).to eq(false)
    end

  end
end

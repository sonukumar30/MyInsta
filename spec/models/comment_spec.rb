require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'comment' do
    let(:user){build :user}
    let(:post) {build :post}
    let (:comment){build :comment,post:post,user:user}
    let (:comment1){build :comment}
    let (:comment2){build :comment,user:user}

    it 'valid comment' do
      expect(comment.valid?).to eq(true)
    end


    it 'Invalid comment without post and user' do
      expect(comment1.valid?).to eq(false)
    end

    it 'Invalid comment without post' do
      expect(comment2.valid?).to eq(false)
    end

  end
end

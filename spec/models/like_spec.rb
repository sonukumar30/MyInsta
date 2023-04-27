require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'like ' do
    let(:user){build :user}
    let(:post){build :post}
    let(:comment){build :comment}

    let(:like1){build :like,likeable: post,user:user}
    let(:like2){build :like,likeable: comment,user:user}
    let(:like3){build :like}

    it 'like on post' do
      expect(like1.valid?).to eq(true)
    end

    it 'post like' do
      expect(like1.likeable).to eq(post)
    end

    it 'like on comment' do
      expect(like2.valid?).to eq(true)
    end

    it 'comment like' do
      expect(like2.likeable).to eq(comment)
    end
   
    it 'invalid ' do
      expect(like3.valid?).to eq(false)
    end


  end
 
end

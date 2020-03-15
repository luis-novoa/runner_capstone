require 'rails_helper'
require 'spec_helper'

RSpec.describe Transaction, type: :model do
  let(:test_user) { User.create(name: 'test') }
  let(:test_post) { Transaction.new(name: 'test2', amount: 1, user_id: test_user.id) }

  describe 'validations' do
    it 'check for name presence' do
      test_post.name = nil
      expect(test_post.save).to eq(false)
    end

    it "check for name's minimum characters" do
      test_post.name = 'a'
      expect(test_post.save).to eq(false)
    end

    it "check for name's maximum characters" do
      test_post.name = 'a'*51
      expect(test_post.save).to eq(false)
    end

    it 'check for amount presence' do
      test_post.amount = nil
      expect(test_post.save).to eq(false)
    end

    it 'check for amount numericality' do
      test_post.amount = 'whatever'
      expect(test_post.save).to eq(false)
    end

    it 'check if amount is integer' do
      test_post.amount = 0.01
      expect(test_post.save).to eq(false)
    end

    it 'check if amount bigger than 0' do
      test_post.amount = 0
      expect(test_post.save).to eq(false)
    end
  end
end

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  let(:test_user) {User.new}

  describe 'validations' do
    it 'check for name presence' do
      expect(test_user.save).to eq(false)
    end

    it "check for name's minimum characters" do
      test_user.name = 'a'
      expect(test_user.save).to eq(false)
    end

    it "check for name's maximum characters" do
      test_user.name = 'a'*21
      expect(test_user.save).to eq(false)
    end
  end
end

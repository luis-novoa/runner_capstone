require 'rails_helper'
require 'spec_helper'

RSpec.describe Group, type: :model do
  let(:test_user) { User.create(name: 'test') }
  let(:test_group) { Group.new(name: 'test2', icon: 'walking', user_id: test_user.id) }

  describe 'Validations' do
    it 'check for name presence' do
      test_group.name = nil
      expect(test_group.save).to eq(false)
    end

    it "check for name's minimum characters" do
      test_group.name = 'a'
      expect(test_group.save).to eq(false)
    end

    it "check for name's maximum characters" do
      test_group.name = 'a'*51
      expect(test_group.save).to eq(false)
    end

    it 'check for icon presence' do
      test_group.icon = nil
      expect(test_group.save).to eq(false)
    end

    it 'check if icon is valid' do
      test_group.icon = 'cat'
      expect(test_group.save).to eq(false)
    end
  end
end

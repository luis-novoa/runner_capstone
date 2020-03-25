require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/show.html.erb", type: :feature do

  context 'not logged in' do
    scenario 'visit user main page' do
      test_user.save
      visit user_path(test_user)
      expect(current_path).to eq(root_path)
    end
  end

  context 'logged in' do

    scenario "show user's transactions" do
      login
      test_transaction.save
      refresh
      expect(page).to have_selector 'span', text: 'user transaction'
    end
  end

end
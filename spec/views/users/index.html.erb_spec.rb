require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/index.html.erb", type: :feature do
  context 'not logged in' do
    scenario 'visit users index' do
      visit users_path
      expect(current_path).to eq(root_path)
    end
  end

  context 'logged in' do
    scenario 'link to menu' do
      login
      visit users_path
      expect(page).to have_link href: users_path(show_menu: true)
    end

    scenario "current user isn't listed" do
      login
      visit users_path
      expect(page).to have_no_link href: user_path(test_user)
    end

    scenario "other users are listed" do
      login
      test_user2.save
      visit users_path
      expect(page).to have_link href: user_path(test_user2)
    end
  end
end
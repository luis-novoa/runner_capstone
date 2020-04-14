require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'layouts/application.html.erb', type: :feature do
  context 'links' do
    scenario 'user name' do
      login
      click_link class: 'fa-bars'
      expect(page).to have_selector 'span', text: test_user.name
    end

    scenario 'all my tracks' do
      login
      click_link class: 'fa-bars'
      click_link 'ALL MY TRACKS'
      expect(current_path).to eq(user_path(test_user))
    end

    scenario 'my individual tracks' do
      login
      click_link class: 'fa-bars'
      click_link 'MY INDIVIDUAL TRACKS'
      expect(page).to have_current_path(user_path(test_user, groupless: true))
    end

    scenario 'all groups' do
      login
      click_link class: 'fa-bars'
      click_link 'ALL GROUPS'
      expect(current_path).to eq(groups_path)
    end

    scenario 'other users' do
      login
      click_link class: 'fa-bars'
      click_link 'OTHER USERS'
      expect(current_path).to eq(users_path)
    end

    scenario 'logout' do
      login
      click_link class: 'fa-bars'
      click_link 'LOG OUT'
      visit user_path(test_user)
      expect(current_path).to eq(root_path)
    end
  end

  context 'previous screen' do
    scenario 'main page' do
      login
      click_link class: 'fa-bars'
      click_link class: 'miniature-anchor'
      expect(current_path).to eq(user_path(test_user))
    end

    scenario 'my individual tracks' do
      login
      visit user_path(test_user, groupless: true)
      click_link class: 'fa-bars'
      click_link class: 'miniature-anchor'
      expect(page).to have_current_path(user_path(test_user, groupless: true))
    end

    scenario 'all groups' do
      login
      visit groups_path
      click_link class: 'fa-bars'
      click_link class: 'miniature-anchor'
      expect(current_path).to eq(groups_path)
    end

    scenario 'other users' do
      login
      visit users_path
      click_link class: 'fa-bars'
      click_link class: 'miniature-anchor'
      expect(current_path).to eq(users_path)
    end
  end
end
# rubocop:enable Metrics/BlockLength

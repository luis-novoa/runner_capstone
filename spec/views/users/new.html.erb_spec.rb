require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'users/new.html.erb', type: :feature do
  context 'login' do
    scenario 'existent username' do
      test_user.save
      visit root_path
      fill_in 'user_name', with: 'user'
      click_button 'LOG IN'
      expect(current_path).to eq(user_path(test_user))
    end

    scenario 'new username' do
      visit root_path
      fill_in 'user_name', with: 'user'
      click_button 'LOG IN'
      expect(page).to have_selector '.notification', text: 'User not found. Click on sign up to create a new user.'
    end

    scenario 'blank username' do
      visit root_path
      fill_in 'user_name', with: ''
      click_button 'LOG IN'
      expect(page).to have_selector '.notification', text: 'User not found. Click on sign up to create a new user.'
    end

    scenario 'short username' do
      test_user.save
      visit root_path
      fill_in 'user_name', with: 'te'
      click_button 'LOG IN'
      expect(page).to have_selector '.notification', text: 'User not found. Click on sign up to create a new user.'
    end

    scenario 'failed attempt and refresh' do
      visit root_path
      click_button 'LOG IN'
      visit current_path
      expect(current_path).to eq(root_path)
    end
  end

  context 'signup' do
    scenario 'existent username' do
      test_user.save
      visit root_path
      fill_in 'user_name', with: 'user'
      click_button 'SIGN UP'
      expect(page).to have_selector '.notification', text: 'Name has already been taken'
    end

    scenario 'new username' do
      visit root_path
      fill_in 'user_name', with: 'user'
      click_button 'SIGN UP'
      expect(page).to have_selector 'h1', text: 'ALL MY TRACKS'
    end

    scenario 'blank username' do
      test_user.save
      visit root_path
      fill_in 'user_name', with: ''
      click_button 'SIGN UP'
      expect(page).to have_selector '.notification', text: "Name can't be blank"
    end

    scenario 'short username' do
      test_user.save
      visit root_path
      fill_in 'user_name', with: 'te'
      click_button 'SIGN UP'
      expect(page).to have_selector '.notification', text: 'Name is too short (minimum is 3 characters)'
    end

    scenario 'failed attempt and refresh' do
      visit root_path
      click_button 'SIGN UP'
      visit current_path
      expect(current_path).to eq(root_path)
    end
  end

  context 'logged in' do
    scenario 'redirects to user page' do
      login
      visit root_path
      expect(current_path).to eq(user_path(test_user))
    end
  end
end
# rubocop:enable Metrics/BlockLength

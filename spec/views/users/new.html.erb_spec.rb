require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/new.html.erb", type: :feature do
  # let(:test_user) { User.new(name: 'test') }

  scenario 'logging in with inexistent username fails' do
    visit root_path
    fill_in 'user_name', with: 'test'
    click_button 'LOG IN'
    expect(page).to have_selector '.notification', text: "User not found. Click on sign up to create a new user."
  end

  scenario 'signing up with existent username fails' do
    test_user.save
    visit root_path
    fill_in 'user_name', with: 'test'
    click_button 'SIGN UP'
    expect(page).to have_selector '.notification', text: 'Name has already been taken'
  end

  scenario 'succesfull log in leads to user page' do
    test_user.save
    visit root_path
    fill_in 'user_name', with: 'test'
    click_button 'LOG IN'
    expect(current_path).to eq(user_path(test_user))
  end

  scenario 'succesful sign up leads to user page' do
    visit root_path
    fill_in 'user_name', with: 'test'
    click_button 'SIGN UP'
    expect(page).to have_selector 'h1', text: 'ALL MY TRACKS'
  end

  scenario 'visiting homepage while logged in leads you to the user page' do
    login
    visit root_path
    expect(current_path).to eq(user_path(test_user))
  end
end

require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/new.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }

  scenario 'logging in with inexistent username fails' do
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
    expect(page).to have_selector '.alert', text: "User doesn't exist. Try to sign up!"
  end

  scenario 'signing up with existent username fails' do
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Sign Up'
    expect(page).to have_selector '.alert', text: 'User exists. Try to log in!'
  end

  scenario 'succesfull log in leads to user page' do
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
    expect(current_path).to eq(user_path(test_user))
  end

  scenario 'succesful sign up leads to user page' do
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Sign Up'
    expect(page).to have_selector 'p', text: 'test'
  end

  scenario 'visiting homepage while logged in leads you to the user page' do
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
    visit root_path
    expect(current_path).to eq(user_path(test_user))
  end
end

require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/new.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }

  scenario 'trying to log in with inexistent username fails' do
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
    expect(page).to have_selector '.alert', text: "User doesn't exist. Try to sign up!"
  end

  scenario 'trying to sign up with existent username fails' do
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Sign Up'
    expect(page).to have_selector '.alert', text: 'User exists. Try to log in!'
  end
end

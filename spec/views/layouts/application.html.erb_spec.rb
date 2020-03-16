require 'rails_helper'
require 'spec_helper'

RSpec.describe "layouts/application.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }

  def login
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
  end

  scenario 'logged user can logout' do
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
    click_link 'Log out'
    visit new_transaction_path
    expect(current_path).to eq(root_path)
  end

  scenario "there is a link to check all user's transactions" do
    login
    visit new_transaction_path
    click_link 'All my Transactions'
    expect(current_path).to eq(user_path(test_user))
  end
end
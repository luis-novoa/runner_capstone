require 'rails_helper'
require 'spec_helper'

RSpec.describe "transactions/new.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }

  def login
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
  end

  scenario 'access the page while not logged in redirects you to home page' do
    visit new_transaction_path
    expect(current_path).to eq(root_path)
  end

  scenario 'the page creates a post correctly' do
    login
    visit new_transaction_path
    fill_in 'Name', with: 'test2'
    fill_in 'Amount', with: 3
    click_button 'Create'
    expect(page).to have_selector 'p', text: 'test2'
  end

  scenario 'page alerts errors when sending wrong form' do
    login
    visit new_transaction_path
    fill_in 'Name', with: 'test2'
    click_button 'Create'
    expect(page).to have_selector '.alert'
  end
end
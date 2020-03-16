require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/show.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }
  let(:test_transaction) { Transaction.new(name: 'test2', amount: 1, user_id: test_user.id) }

  def login
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
  end

  scenario 'access the page while not logged in redirects you to home page' do
    test_user.save
    visit user_path(test_user)
    expect(current_path).to eq(root_path)
  end

  scenario "user's transactions appear on the user page" do
    login
    test_transaction.save
    visit user_path(test_user)
    expect(page).to have_selector 'p', text: 'test2'
  end
end
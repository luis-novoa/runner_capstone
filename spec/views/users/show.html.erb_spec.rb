require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/show.html.erb", type: :feature do

  scenario 'access the page while not logged in redirects you to home page' do
    test_user.save
    visit user_path(test_user)
    expect(current_path).to eq(root_path)
  end

  scenario "user's transactions appear on the user page" do
    login
    test_transaction.save
    refresh
    expect(page).to have_selector 'span', text: 'transaction'
  end
end
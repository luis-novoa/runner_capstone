require 'rails_helper'
require 'spec_helper'

RSpec.describe "layouts/application.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }

  scenario 'logged user can logout' do
    test_user.save
    visit root_path
    fill_in 'Name', with: 'test'
    click_button 'Log In'
    click_link 'Log out'
    visit new_transaction_path
    expect(current_path).to eq(root_path)
  end
end
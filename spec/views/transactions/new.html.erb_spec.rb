require 'rails_helper'
require 'spec_helper'

RSpec.describe "transactions/new.html.erb", type: :feature do

  scenario 'access the page while not logged in redirects you to home page' do
    visit new_transaction_path
    expect(current_path).to eq(root_path)
  end
end
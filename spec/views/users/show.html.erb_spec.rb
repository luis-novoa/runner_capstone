require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/show.html.erb", type: :feature do
  let(:test_user) { User.new(name: 'test') }

  scenario 'access the page while not logged in redirects you to home page' do
    test_user.save
    visit user_path(test_user)
    expect(current_path).to eq(root_path)
  end
end
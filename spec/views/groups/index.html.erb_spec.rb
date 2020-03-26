require 'rails_helper'
require 'spec_helper'

RSpec.describe "groups/index.html.erb", type: :feature do

  scenario 'not logged in' do
    visit groups_path
    expect(current_path).to eq(root_path)
  end
end
require 'rails_helper'
require 'spec_helper'

RSpec.describe "groups/new.html.erb", type: :feature do

  scenario "not logged in" do
    visit create_group_path
    expect(current_path).to eq(root_path)
  end

  context 'logged in' do
    scenario "previous page link" do
      login
      visit create_group_path
      click_link class: "fa-arrow-left"
      expect(current_path).to eq(groups_path)
    end
  end
end
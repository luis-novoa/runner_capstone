require 'rails_helper'
require 'spec_helper'

RSpec.describe "groups/index.html.erb", type: :feature do

  scenario 'not logged in' do
    visit groups_path
    expect(current_path).to eq(root_path)
  end

  context 'logged in' do
    scenario 'link to menu' do
      login
      visit groups_path
      expect(page).to have_link href: groups_path(show_menu: true)
    end

    scenario "groups are listed" do
      login
      test_group2.save
      visit groups_path
      expect(page).to have_link href: group_path(test_group2)
    end

    scenario 'link to create group' do
      login
      visit groups_path
      click_link 'CREATE NEW GROUP'
      expect(current_path).to eq(create_group_path)
    end
  end
end
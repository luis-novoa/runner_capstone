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

    scenario 'create group' do
      login
      visit create_group_path
      fill_in 'group_name', with: 'test'
      click_button 'Create'
      expect(page).to have_selector 'span', text: 'test'
    end

    scenario 'failed attempt and refresh' do
      login
      visit create_group_path
      click_button 'Create'
      visit current_path
      expect(current_path).to eq(create_group_path)
    end

    scenario 'nameless group' do
      login
      visit create_group_path
      fill_in 'group_name', with: ''
      click_button 'Create'
      expect(page).to have_selector '.notification', text: "Name can't be blank"
    end

    scenario 'short name group' do
      login
      visit create_group_path
      fill_in 'group_name', with: 't'
      click_button 'Create'
      expect(page).to have_selector '.notification', text: 'Name is too short (minimum is 2 characters)'
    end
  end
end
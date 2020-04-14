require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'groups/show.html.erb', type: :feature do
  scenario 'not logged in' do
    visit groups_path
    expect(current_path).to eq(root_path)
  end

  context 'logged in' do
    scenario 'right title' do
      login
      test_group2.save
      visit group_path(test_group2)
      expect(page).to have_selector 'h1', text: 'GROUP2 TRACKS'
    end

    scenario 'link to previous page' do
      login
      test_group.save
      visit group_path(test_group)
      click_link class: 'fa-arrow-left'
      expect(current_path).to eq(groups_path)
    end

    scenario 'link to new track' do
      login
      test_group2.save
      visit group_path(test_group2)
      expect(page).to have_link 'ADD NEW TRACK', href: new_transaction_path(group_id: test_group2.id)
    end

    scenario "show target group's tracks" do
      login
      test_group2.save
      test_transaction3.save
      visit group_path(test_group2)
      expect(page).to have_selector 'span', text: 'user transaction3'
    end

    scenario "don't show other group's tracks" do
      login
      test_group.save
      test_transaction2.save
      test_group2.save
      visit group_path(test_group2)
      expect(page).to have_no_selector 'span', text: 'user transaction2'
    end

    scenario 'show track authors' do
      login
      test_group2.save
      test_transaction3.save
      visit group_path(test_group2)
      expect(page).to have_selector 'span', text: test_user.name
    end

    scenario 'show sum of tracks' do
      login
      test_user2.save
      test_group2.save
      test_transaction3.save
      test_transaction6.save
      visit group_path(test_group2)
      expect(page).to have_selector 'span.amount', text: '9 KM'
    end
  end
end
# rubocop:enable Metrics/BlockLength

require 'rails_helper'
require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'users/show.html.erb', type: :feature do
  context 'not logged in' do
    scenario 'visit any user page' do
      test_user.save
      visit user_path(test_user)
      expect(current_path).to eq(root_path)
    end

    scenario 'visit user groupless tracks' do
      test_user.save
      visit user_path(test_user, groupless: true)
      expect(current_path).to eq(root_path)
    end
  end

  context 'logged in' do
    context 'main page' do
      scenario 'right title' do
        login
        expect(page).to have_selector 'h1', text: 'ALL MY TRACKS'
      end

      scenario 'link to menu' do
        login
        expect(page).to have_link href: user_path(test_user, show_menu: true)
      end

      scenario 'link to new track' do
        login
        expect(page).to have_link href: new_transaction_path
      end

      scenario "show logged user's tracks" do
        login
        test_transaction.save
        refresh
        expect(page).to have_selector 'span', text: 'user transaction'
      end

      scenario "don't show other user's tracks" do
        login
        test_transaction.save
        test_user2.save
        test_transaction4.save
        refresh
        expect(page).to have_no_selector 'span', text: 'user2 transaction'
      end

      scenario 'show group tracks' do
        login
        test_group.save
        test_transaction2.save
        refresh
        expect(page).to have_selector 'i.fas.fa-walking'
      end

      scenario 'show sum of tracks' do
        login
        test_group.save
        test_group2.save
        test_transaction.save
        test_transaction2.save
        test_transaction3.save
        refresh
        expect(page).to have_selector 'span.amount', text: '6 KM'
      end
    end

    context 'individual page' do
      scenario 'right title' do
        login
        visit user_path(test_user, groupless: true)
        expect(page).to have_selector 'h1', text: 'MY INDIVIDUAL TRACKS'
      end

      scenario 'link to menu' do
        login
        visit user_path(test_user, groupless: true)
        expect(page).to have_link href: user_path(test_user, show_menu: true, groupless: true)
      end

      scenario 'link to new track' do
        login
        visit user_path(test_user, groupless: true)
        expect(page).to have_link href: new_transaction_path
      end

      scenario "show logged user's tracks" do
        login
        test_transaction.save
        visit user_path(test_user, groupless: true)
        expect(page).to have_selector 'span', text: 'user transaction'
      end

      scenario "don't show other user's tracks" do
        login
        test_transaction.save
        test_user2.save
        test_transaction4.save
        visit user_path(test_user, groupless: true)
        expect(page).to have_no_selector 'span', text: 'user2 transaction'
      end

      scenario "don't show group tracks" do
        login
        test_group.save
        test_transaction2.save
        visit user_path(test_user, groupless: true)
        expect(page).to have_no_selector 'i.fas.fa-walking'
      end

      scenario 'show sum of tracks' do
        login
        test_transaction.save
        test_transaction7.save
        visit user_path(test_user, groupless: true)
        expect(page).to have_selector 'span.amount', text: '8 KM'
      end
    end

    context 'other user page' do
      scenario 'right title' do
        login
        test_user2.save
        visit user_path(test_user2)
        expect(page).to have_selector 'h1', text: 'USER2 TRACKS'
      end

      scenario 'link to users index' do
        login
        test_user2.save
        visit user_path(test_user2)
        expect(page).to have_link href: users_path
      end

      scenario 'no link to new track' do
        login
        test_user2.save
        visit user_path(test_user2)
        expect(page).to have_no_link href: new_transaction_path
      end

      scenario "show target user's tracks" do
        login
        test_user2.save
        test_transaction4.save
        visit user_path(test_user2)
        expect(page).to have_selector 'span', text: 'user2 transaction'
      end

      scenario "don't show other user's tracks" do
        login
        test_transaction.save
        test_user2.save
        test_transaction4.save
        visit user_path(test_user2)
        expect(page).to have_no_selector 'span', text: 'user transaction'
      end

      scenario 'show group tracks' do
        login
        test_group.save
        test_user2.save
        test_transaction5.save
        visit user_path(test_user2)
        expect(page).to have_selector 'i.fas.fa-walking'
      end

      scenario 'show sum of tracks' do
        login
        test_user2.save
        test_group.save
        test_group2.save
        test_transaction4.save
        test_transaction5.save
        test_transaction6.save
        visit user_path(test_user2)
        expect(page).to have_selector 'span.amount', text: '15 KM'
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

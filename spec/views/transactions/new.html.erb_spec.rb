require 'rails_helper'
require 'spec_helper'

RSpec.describe "transactions/new.html.erb", type: :feature do

  context 'not logged in' do
    scenario "page is unreachable" do
      visit new_transaction_path
      expect(current_path).to eq(root_path)
    end
  end

  context 'logged in' do
    context 'access from user page' do
      scenario "previous page link" do
        login
        visit new_transaction_path
        click_link class: "fa-arrow-left"
        expect(current_path).to eq(user_path(test_user))
      end
  
      scenario 'groupless transaction' do
        login
        visit new_transaction_path
        fill_in 'transaction_name', with: 'test2'
        fill_in 'transaction_amount', with: 3
        click_button 'Create'
        expect(page).to have_selector 'span', text: 'test2'
      end
  
      scenario 'creates group transaction' do
        login
        test_group.save
        visit new_transaction_path
        fill_in 'transaction_name', with: 'test2'
        fill_in 'transaction_amount', with: 3
        select(test_group.name, from: "transaction_group_id").select_option
        click_button 'Create'
        expect(page).to have_selector 'i.fas.fa-walking'
      end
      
      scenario 'nameless transaction' do
        login
        visit new_transaction_path
        fill_in 'transaction_name', with: ''
        fill_in 'transaction_amount', with: 3
        click_button 'Create'
        expect(page).to have_selector '.notification', text: "Name can't be blank"
      end

      scenario 'nameless transaction' do
        login
        visit new_transaction_path
        fill_in 'transaction_name', with: 't'
        fill_in 'transaction_amount', with: 3
        click_button 'Create'
        expect(page).to have_selector '.notification', text: "Name is too short (minimum is 2 characters)"
      end

      scenario 'amountless transaction' do
        login
        visit new_transaction_path
        fill_in 'transaction_name', with: 'test'
        fill_in 'transaction_amount', with: ''
        click_button 'Create'
        expect(page).to have_selector '.notification', text: "Amount can't be blank"
      end

      scenario 'zero distance transaction' do
        login
        visit new_transaction_path
        fill_in 'transaction_name', with: 'test'
        fill_in 'transaction_amount', with: '0'
        click_button 'Create'
        expect(page).to have_selector '.notification', text: "Amount must be greater than 0"
      end
    end

    context 'access from group page' do
      scenario 'pre-selected group' do
        login
        test_group.save
        visit group_path(test_group)
        click_link 'ADD NEW TRACK'
        group_selected = find_field('transaction_group_id').find('option[selected]').text
        expect(group_selected).to eq(test_group.name)
      end

      scenario "previous page link" do
        login
        test_group.save
        visit group_path(test_group)
        click_link 'ADD NEW TRACK'
        click_link class: "fa-arrow-left"
        expect(current_path).to eq(group_path(test_group))
      end
    end
  end
end
module Helpers
  def login
    test_user.save
    visit root_path
    fill_in 'user_name', with: 'user'
    click_button 'LOG IN'
  end
end

RSpec.shared_context 'Global variables' do
  let(:test_user) { User.new(name: 'user') }
  let(:test_user2) { User.new(name: 'user2') }
  let(:test_group) { Group.new(name: 'group', icon: 'walking', user_id: test_user.id) }
  let(:test_group2) { Group.new(name: 'group2', icon: 'horse', user_id: test_user.id) }
  let(:test_transaction) { Transaction.new(name: 'user transaction', amount: 1, user_id: test_user.id) }
  let(:test_transaction2) { Transaction.new(name: 'user transaction2', amount: 2, user_id: test_user.id, group_id: test_group.id) }
  let(:test_transaction3) { Transaction.new(name: 'user transaction3', amount: 3, user_id: test_user.id, group_id: test_group2.id) }
  let(:test_transaction4) { Transaction.new(name: 'user2 transaction', amount: 4, user_id: test_user2.id) }
  let(:test_transaction5) { Transaction.new(name: 'user2 transaction2', amount: 5, user_id: test_user2.id, group_id: test_group.id) }
  let(:test_transaction6) { Transaction.new(name: 'user2 transaction3', amount: 6, user_id: test_user2.id, group_id: test_group2.id) }
  let(:test_transaction7) { Transaction.new(name: 'user transaction4', amount: 7, user_id: test_user.id) }

end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include_context 'Global variables'
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random
  Kernel.srand config.seed
  # config.profile_examples = 10
  config.include Helpers
end


class TransactionsController < ApplicationController
  def new
    logged_in?
    @transaction = Transaction.new
  end

  def create
    @new_transaction = current_user.transactions.build(transaction_params)
    @new_transaction.save
    redirect_to current_user
  end

  private
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :group_id)
  end
end

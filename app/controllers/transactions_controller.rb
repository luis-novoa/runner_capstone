class TransactionsController < ApplicationController
  def new
    logged_in?
    @transaction = Transaction.new
    @groups = Group.all
    @group_select = [['No Group','']]
    @groups.each do |group|
      @group_select.push([group.name, group.id])
    end
  end

  def create
    @new_transaction = current_user.transactions.build(transaction_params)
    if @new_transaction.save
      redirect_to current_user
    else
      flash.now[:alert] = @new_transaction.errors.full_messages
      @transaction = @new_transaction
      @group_select = [['No Group','']]
      @groups = Group.all
      @groups.each do |group|
        @group_select.push([group.name, group.id])
      end
      render 'new'
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :group_id)
  end
end

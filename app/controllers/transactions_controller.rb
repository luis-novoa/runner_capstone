class TransactionsController < ApplicationController
  def new
    logged_in?
    @transaction = Transaction.new
  end

  # def create
    
  # end

end

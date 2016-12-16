class ReceiptsController < ApplicationController
  def create
    borrower = Borrower.find(params[:borrower])
    lender = Lender.find(session[:user_id])
    amount = params[:amount]
    temp = amount.to_i
    temp2 = lender.money - temp
    puts '*********************8'
    puts temp2
    puts '*********************8'
    if temp2 < 0
      flash[:msg] = "Insufficient Funds!"
      redirect_to :back
    else
      Receipt.create(borrower:borrower, lender:lender, amount:amount)
      borrower.update(raised:amount)
      puts '*********************8'
      puts temp2
      puts '*********************8'
      lender.update(money:temp2)
      puts '*********************8'
      puts 'The lenders money is'
      puts lender.money
      puts '*********************8'
      redirect_to :back
    end
  end
end

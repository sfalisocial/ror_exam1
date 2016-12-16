class LendersController < ApplicationController
  def create
    form = params[:lender]
    if form[:password] == form[:password_confirmation]
      user = Lender.create(lender_params)
      flash[:msg] = user.errors.full_messages
      redirect_to '/'
    else
      flash[:msg] = "Invalid credentials!"
      redirect_to '/'
    end
  end

  def show
    id = params[:id]
    @user = Lender.find(id)
    b = Borrower.all
    c = []
    b.each do |item|
      if item.money_raised.exclude? @user
        c.push(item)
      end
    end
    puts '*********************8'
    puts c
    puts '*********************8'
    @borrowers = c
    @my_borrowers = Receipt.joins(:borrower).where(lender:id).select('borrowers.first_name AS first_name', :amount, :purpose, :description, :needed, :raised)
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  end
end

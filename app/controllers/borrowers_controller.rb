class BorrowersController < ApplicationController
  def create
    form = params[:borrower]
    if form[:password] == form[:password_confirmation]
      user = Borrower.new(borrower_params)
      user.raised = 0
      user.save
      flash[:msg] = user.errors.full_messages
      redirect_to '/'
    else
      flash[:msg] = "Invalid credentials!"
      redirect_to '/'
    end
  end

  def show
    id = params[:id]
    @user = Borrower.find(id)
    @lenders = Receipt.joins(:lender).where(borrower:id)
  end
  private
  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description, :needed)
  end
end

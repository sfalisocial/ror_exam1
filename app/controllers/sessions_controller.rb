class SessionsController < ApplicationController
  def register
  end

  def login
  end

  def create
    lender = Lender.find_by_email(params[:email])
    borrower = Borrower.find_by_email(params[:email])
    if borrower == nil
      if lender && lender.authenticate(params[:password])
        flash[:msg] = "Successfully logged in!"
        session[:user_id] = lender.id
        redirect_to "/lenders/#{lender.id}"
      else
        flash[:msg] = "Invalid credintials"
        redirect_to "/"
      end
    else
      if borrower && borrower.authenticate(params[:password])
        flash[:msg] = "Successfully logged in!"
        session[:user_id] = borrower.id
        redirect_to "/borrowers/#{borrower.id}"
      else
        flash[:msg] = "Invalid credintials"
        redirect_to "/"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end

class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if !subscription.valid?
      redirect_to :back, notice: "Please enter both amounts"
    end

    if @subscription.verify_account
      start_recurring_payments
      redirect_to user_path
    else
      # redirect_to :back, notice: "Those deposit amounts are not correct"
    end
  end
end

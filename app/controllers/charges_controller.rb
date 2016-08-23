class ChargesController < ApplicationController
  def new
  end

  def create
    begin
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount:   amount(customer),
        currency: "usd"
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :back
    end

    redirect_to :back, notice: "You successfully subscribed!"
  end

  private

  def customer
    @customer ||= Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken],
      plan:   params[:plan]
    )
  end

  def amount(response)
    response["subscriptions"]["data"][0]["plan"]["amount"]
  end
end

class Charge
  include Interactor

  delegate :customer, to: :context

  def call
    context.charge = charge
  end

  private

  def charge
    Stripe::Charge.create(
      customer: customer.id,
      amount:   amount(customer),
      currency: "usd"
    )
  end

  def amount(stripe_customer)
    stripe_customer["subscriptions"]["data"][0]["plan"]["amount"]
  end
end

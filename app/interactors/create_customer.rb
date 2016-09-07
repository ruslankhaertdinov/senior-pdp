class CreateCustomer
  include Interactor

  delegate :params, to: :context

  def call
    context.customer = customer
  end

  private

  def customer
    Stripe::Customer.create(
      source: params[:stripeToken],
      plan:   params[:plan],
      email:  params[:stripeEmail]
    )
  end
end

class CreateSubscription
  include Interactor

  delegate :params, :user, :charge, to: :context

  def call
    subscription = Subscription.new(subscription_params)
    context.fail!(message: subscription.errors.to_a) unless subscription.save
  end

  private

  def subscription_params
    {
      author_id: params[:author_id],
      active_until: active_until,
      user_id: user.id,
      stripe_charge_id: charge.id
    }
  end

  def active_until
    period = Subscription::PERIODS[params[:plan]]
    1.send(period.to_sym).from_now
  end
end

class CreateSubscription
  include Interactor

  PERIODS = {
    starter: 1.week.from_now,
    basic: 1.month.from_now,
    pro: 1.year.from_now
  }.stringify_keys

  delegate :params, :user, :charge, to: :context

  def call
    subscription = Subscription.new(subscription_params)
    context.fail!(message: subscription.errors.to_a) unless subscription.save
  end

  private

  def subscription_params
    {
      author_id: params[:author_id],
      active_until: PERIODS[params[:plan]],
      user_id: user.id,
      stripe_charge_id: charge.id
    }
  end
end

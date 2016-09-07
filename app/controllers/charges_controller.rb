class ChargesController < ApplicationController
  def new
  end

  def create
    begin
      result = Subscribe.call(params: subscription_params, user: current_user)
    rescue Stripe::CardError => e
      flash[:error] = e.message
    end

    if result.success?
      flash[:notice] = "You successfully subscribed!"
    else
      flash[:error] = result.message
    end

    redirect_to user_articles_path(user_id: subscription_params[:author_id])
  end

  private

  def subscription_params
    attributes = %i(plan author_id stripeToken stripeTokenType stripeEmail)
    params.permit(attributes)
  end
end

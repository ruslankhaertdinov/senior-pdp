class ChargesController < ApplicationController
  def create
    begin
      result = Subscribe.call(params: subscription_params, user: current_user)
      flash[:notice] = "You successfully subscribed!" if result.success?
      flash[:error] = result.message if result.failure?
    rescue Stripe::CardError => e
      flash[:error] = e.message
    end

    redirect_to user_articles_path(user_id: subscription_params[:author_id])
  end

  private

  def subscription_params
    attributes = %i(plan author_id stripeToken stripeTokenType stripeEmail)
    params.permit(attributes)
  end
end

class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html, :json

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end

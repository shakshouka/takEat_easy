class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }

    # Make sure your production DOMAIN variable is set with your domain name. If you deploy your code with Heroku for instance, just type in your terminal:

    # heroku config:set DOMAIN=www.takeateasy.club

    #You can check it's properly set with heroku config:get DOMAIN.

  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end

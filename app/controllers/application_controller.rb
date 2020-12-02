class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :add_www_subdomain

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def add_www_subdomain
    unless /^www/.match(request.host) || request.host == "localhost"
      redirect_to("#{request.protocol}www.takeateasy.club#{request.fullpath}",
                  :status => 301)
    end
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  
    # Make sure your production DOMAIN variable is set with your domain name. If you deploy your code with Heroku for instance, just type in your terminal:

    # heroku config:set DOMAIN=www.my_product.com

    #You can check it's properly set with heroku config:get DOMAIN.

  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end

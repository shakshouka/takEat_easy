class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      redirect_to 'weeks/1/today'
    end
  end

  def random
  end

  def swipe
  end
end

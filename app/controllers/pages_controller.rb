class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      week_id = Week.last.id
      redirect_to "/weeks/#{week_id}/today"
    end
  end

  def random
  end

  def swipe
  end
end

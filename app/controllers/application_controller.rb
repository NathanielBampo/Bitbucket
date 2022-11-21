class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :notfound

  def notfound
    render file: 'public/404.html', status: :not_found, layout: false
  end


  protect_from_forgery with: :exception
end

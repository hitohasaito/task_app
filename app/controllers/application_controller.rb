class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  class MyError < StandardError
  end
#binding.pry
  rescue_from MyError, with: :myerror
#binding.pry
  def myerror
    render "errors/myerror.html.erb"
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  class MyError < StandardError
  end

  rescue_from MyError, with: :myerror

  def myerror
    render "errors/myerror"
  end
end

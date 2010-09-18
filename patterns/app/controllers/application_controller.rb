class ApplicationController < ActionController::Base

  include ExceptionNotification::Notifiable

  helper :all
  protect_from_forgery
end
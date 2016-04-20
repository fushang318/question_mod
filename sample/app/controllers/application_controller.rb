class ApplicationController < ActionController::Base
  helper TimeHelper

  if defined? PlayAuth
    helper PlayAuth::SessionsHelper
    include PlayAuth::SessionsHelper
  end
end

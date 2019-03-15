class ApplicationController < ActionController::Base
  add_flash_types :alertt  #:success, :info, :warning, :danger # flashメッセージは「notice」と「alert」の2種類のキーしか設定してないから、追加するには、ここ

  # include ActionController::HttpAuthentication::Token::ControllerMethods

  # before_action :authenticate

  # protected

  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     token == ENV['API_TOKEN']
  #   end
  # end

end

require "application_responder"

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  respond_to :html

    include JWTSessions::RailsAuthorization
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
    include ActionController::MimeResponds
    private
    
    def current_user
        @current_user ||= User.find(payload['user_id'])
    end
    def not_authorized
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
end

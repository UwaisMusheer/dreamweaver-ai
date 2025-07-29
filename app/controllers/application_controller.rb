class ApplicationController < ActionController::Base
  include Pundit

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Handle unauthorized access
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    respond_to do |format|
      format.json { render json: { error: "You are not authorized to perform this action." }, status: :forbidden }
      format.html { redirect_to(request.referrer || root_path, alert: "You are not authorized to perform this action.") }
    end
  end
end

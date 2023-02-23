class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def search
      @tracks = Track.where("title LIKE ?", "%#{params[:search]}%")
      @users = User.where("name LIKE ?", "%#{params[:search]}%")
    end
end

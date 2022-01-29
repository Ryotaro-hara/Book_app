class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :configure_account_update_parameters, if: :devise_controller?
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end


    protected
    def after_sign_in_path_for(resource)
		root_path
	end
	
	def after_sign_out_path_for(resource)
		root_path
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    end

    def configure_account_update_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction,:email ,:image,:password])
        devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
    end

end

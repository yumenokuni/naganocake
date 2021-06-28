class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #ログアウト後遷移先
  def after_sign_out_path_for(resource_or_scope)
    return new_admin_session_path if resource_or_scope == :admin
    root_path
  end

  #ログイン後遷移先
  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_orders_path
      when Customer
        root_path
    end
  end

  #サインアップ後の遷移先はregistrations_controllerに記載

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end


end
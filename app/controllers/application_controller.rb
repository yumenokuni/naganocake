class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #新規登録後遷移先
  def after_sign_up_path_for(resource)
    my_page_path(resource)
  end

  #ログアウト後遷移先
  def after_sign_out_path_for(resource)
    root_path
  end

  #ログイン後遷移先
  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_orders_path          #pathは設定したい遷移先へのpathを指定してください
      when Customer
        root_path              
    end
  end


 


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end

end
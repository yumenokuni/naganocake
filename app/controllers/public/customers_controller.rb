class Public::CustomersController < ApplicationController
  #顧客側会員ページ

  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  #顧客退会画面
  def unsubscribe
    @customer = current_customer
  end

  #顧客退会処理
  def withdraw
  end

  def update
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :encrypted_password, :is_active)
  end

end

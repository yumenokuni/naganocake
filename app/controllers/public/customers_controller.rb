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
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_path(@customer.id)
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :encrypted_password, :is_active)
  end

end

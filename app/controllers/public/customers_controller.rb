class Public::CustomersController < ApplicationController
def show

end

def edit
 @customer = Customer.find(params[:id])
end

def update
 @customer = Customer.find(params[:id])
  @customer.update(customer_params)
  redirect_to customers_my_page_path
end

def unsubscribe
 @customer = current_customer

end

def quit
 @customer = current_customer
 @customer.update(is_active: false)
 reset_session
 redirect_to root_path
end

private
 def customer_params
   params.require(:customer).permit(:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:address,:telephone_number,:postal_code)
 end
end

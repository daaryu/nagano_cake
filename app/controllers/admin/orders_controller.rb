class Admin::OrdersController < ApplicationController

def show
  @order = Order.find(params[:id])
  @customer = @order.customer
  @order_details = @order.order_details
end

def update
 @order = Order.find(params[:id])
 @order.updete(order_params)
 redirect_to admin_order_path(order.id)
end


private
 def order_params
   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method)
 end
end

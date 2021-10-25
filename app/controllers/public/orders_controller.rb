class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    @cart_items = current_customer.cart_items

    if params[:order][:address_option] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name


    elsif params[:order][:address_option] == "2"
      @address_id = params[:order][:address_id].to_i
      @address = Address.find_by(id: @address_id, customer_id: current_customer.id)
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name


     #findbyを使う


    elsif params[:order][:address_option] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address_new]
      @order.name = params[:order][:name]
      #params[:][:]

    end

  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :name, :address, :shipping_cost, :total_payment, :payment_method, :address_new)
  end
end


class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    redirect_to cart_items_path if current_customer.cart_items.empty?
    #転移先　if  ログインしている顧客のカートにはいいていない？　trueの場合に　redirect_to実行
  end

  def confirm

    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    @cart_items = current_customer.cart_items


    if params[:order][:address_option] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name


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
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.price = (cart_item.item.price * 1.1).floor
      order_detail.amount = cart_item.amount
      order_detail.save
    end
     @cart_items = current_customer.cart_items
     @cart_items.destroy_all
    render :thanks
  end

  def index
    @orders = current_customer.orders

  end

  def show
     @order = Order.find(params[:id])
     @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :name, :address, :shipping_cost, :total_payment, :payment_method, :address_new)
  end
end


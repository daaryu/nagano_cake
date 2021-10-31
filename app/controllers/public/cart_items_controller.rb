class Public::CartItemsController < ApplicationController
    def index
      @cart_item = CartItem.new
      @cart_items = current_customer.cart_items
       # @item = Item.find
       #アソシエーションで定義しているから@itemの記述はいらない

    end

    def update
      @cart_item = CartItem.find(params[:id])
      #一つの商品だからfind.(params[:id])
      @cart_item.update(cart_item_params)
      #変更する内容
      redirect_to cart_items_path
    end

    def destroy_all
     @cart_items = current_customer.cart_items
     @cart_items.destroy_all
     redirect_to cart_items_path

    end

     def destroy
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      redirect_to cart_items_path
     end

    def create
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        having_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        having_cart_item.update(amount: having_cart_item.amount + @cart_item.amount)
        redirect_to cart_items_path
      else
        @cart_item.save
        redirect_to cart_items_path
      end
    end

    private
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :customer_id, :amount)
    end

end

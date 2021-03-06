class Patron::OrdersController < Patron::BaseController

  def index
    @open_orders = Order.where(user_id: current_user.id, status: "Ordered")
    @closed_orders = Order.where(user_id: current_user.id, status: "Completed")
  end

  def new
    @order = Order.new(user_id: current_user.id)
    if @order.save
      # replicate save method with own method. Possible refactor.
      create_join_table_entries(@order)
      flash[:order_success] = "Order was successfully placed"
      session[:cart] = nil
      redirect_to patron_orders_path
    else
      flash[:cart_error] = "Order could not be placed."
      redirect_to cart_path
    end
  end

  def show
    @order = Order.find(params[:id])
    @line_items = OrdersItem.where(order_id: @order.id)
  end

  private

  def create_join_table_entries(order)
    @cart = session[:cart]
    @cart.each_pair do |item, quantity|
      OrdersItem.create!(order_id: order.id, item_id: item.to_i, quantity: quantity )
    end
  end
end

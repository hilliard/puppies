class OrdersController < ApplicationController
  before_action :set_order
  skip_before_filter :authorize, :only => [:new, :create]

  def index
    @orders = Order.paginate :page=>params[:page], :order=>'created_at desc',
    :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @cart = current_cart
    if current_cart.adoptions.empty?
      redirect_to agency_url, :notice => "Your cart is empty"
      return
    end
    
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params[:order])
    @order.add_adoptions_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to(agency_url, :notice => 'Thank you for adopting a puppy!') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    adoption = @order.adoptions.first
    adoption.delivered_on = Time.now
    adoption.save

    respond_to do |format|
      format.html { redirect_to(orders_url, :notice => "Please thank #{@order.name} for the order!") }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end

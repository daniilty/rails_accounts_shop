class OrdersController < ApplicationController
  before_action :adm, only: [:index, :show]
  before_action :checklog, only: [:post_order]
  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
  end
  def delete
    Order.find(params[:id]).delete
  end
  private
  def adm
    if !current_user.admin?
      redirect_to root_url
    end
  end
  def checklog
    if !logged_in?
      redirect_to login_url, notice: "Войдите, чтобы разместить заказ."
    end
  end
  def postpar
    params.require(:order).permit(:email, :id)
  end
end

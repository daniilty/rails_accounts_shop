require 'Date'
class AccountController < ApplicationController
  before_action :adm, only: [:new, :create, :index, :update, :show, :destroy, :edit]
  before_action :islogged, only: [:validate]
  def new
      @ac = Acnt.new
  end
  def create
      @ac = Acnt.create(correct_params)
      if @ac.save
        redirect_to '/account/' + @ac.id.to_s
      end
  end
  def destroy
    Acnt.find(params[:id]).destroy
    redirect_to accounts_url, notice: 'Удачно удален' and return
  end
  def show
    @ac = Acnt.find(params[:id])
  end
  def edit

  end
  def index
    @accs = Acnt.all
  end
  def buy
    @acc = Acnt.new
    @acc_count = Acnt.where(active: false).count
  end
  def validate
    hash = params.require(:acnt)
    dt1 = Date.new(hash["start(1i)"].to_i, hash["start(2i)"].to_i, hash["start(3i)"].to_i)
    dt2 =  Date.new(hash["end(1i)"].to_i, hash["end(2i)"].to_i, hash["end(3i)"].to_i)
    dttd = Date.today
    if (dt1 > dt2)
      redirect_to buy_account_url, notice: "Дата вылета не может быть больше даты прилета" and return
    end
    if (dt1 == dt2)
      redirect_to buy_account_url, notice: "Дата вылета не может быть равна дате прилета" and return
    end
    if((dt2 - dt1).to_i > 16)
      redirect_to buy_account_url, notice: "Бронь аккаунтов на срок больше 16 дней пока что невозможен" and return
    end
    if((dt1 - dttd).to_i > 7)
      redirect_to buy_account_url, notice: "Бронирование должно производиться не раньше недели от вылета" and return
    end
    if (Acnt.where(active: 0).any?)
      @order = Order.new(email: @current_user.email, userid: @current_user.id)
      if @order.save
        redirect_to root_url, notice: "Письмо с инструкциями по оплате было выслано на ваш email." and return
      else
        redirect_to buy_account_url, notice: "Ошибка при размещении заказа."
      end
      # acnt = Acnt.where(active: 0).first
      # acnt.usr_id = current_user.id
      # acnt.save
      # redirect_to user_url(current_user.id) and return
    else
      redirect_to buy_account_url, notice: "На данный момент свободных аккаунтов нет" and return
    end
  end
  def update

  end

  private
  def correct_params
    params.require(:acnt).permit(:email, :pass, :usr_id, :active)
  end
  def adm
    if !current_user.admin?
      redirect_to root_url
    end
  end
  def islogged
    unless logged_in?
      redirect_to login_url, notice: "Пожалуйста войдите в аккаунт"
    end
  end
end

class SubscriptionsController < ApplicationController
	before_action :authenticate_user!

	def index
    if (Subscription.subscribed?(current_user))
      if (Subscription.subscribed?(current_user) > Time.now)
        @subscribed = Subscription.subscribed?(current_user) 
      end
    end

    @subscriptions = Subscription.all
	end

	def new
		@subscription = Subscription.new
	end

	def create
		@subscription = Subscription.new(subscription_params)
	  if @subscription.save
      flash[:success] =  'Подписка была успешно добавлена'
   		redirect_to action: 'index'
  	else
      flash[:danger] = 'Возникла ошибка'
      render :new
  	end
  end

  def purchase
    subscription = Subscription.find_by_id(params[:id])
    if Subscription.subscription_purchase(subscription, current_user)
      flash[:success] = 'Подписка успешно оформлена'
      redirect_to action: 'index'
    else
      flash[:danger] = 'Недостаточно средств на балансе для покупки этой подписки'
      redirect_to action: 'index'
    end
  end

  def destroy
      @subscription = Subscription.find(params[:id]).destroy
      redirect_to action: 'index'
  end


	private
	def subscription_params
      params.require(:subscription).permit(:subtype, :price)
  end

end

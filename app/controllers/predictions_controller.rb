class PredictionsController < ApplicationController
    include ApplicationHelper
	before_action :authenticate_user!, except: [:statistic]
  before_action :check_if_admin, only: [:new, :create, :accept, :decline]

	def index
#    @count_of_purchases = current_user.purchases.where({created_at: Time.now.midnight..(Time.now.midnight + 1.day) }).count
		if current_user.is_admin?
      @admin = true
    else
      @admin = false
    end

    if (Subscription.subscribed?(current_user))
    if (Subscription.subscribed?(current_user) > Time.now)
      @subscribed = Subscription.subscribed?(current_user) 
      end
    end
    @calculated_price = Prediction.calculate_price(current_user)
    @predictions = Prediction.where(status: "")
	end

  def statistic
    @predictions = Prediction.where.not(status: "")
  end

  def accept
    prediction = Prediction.find(params[:id])
    prediction.status = "win"
    prediction.save
    redirect_to predictions_path
  end

  def decline
    prediction = Prediction.find(params[:id])
    prediction.status = "lose"
    prediction.save
    prediction.purchases.each do |f|
      user = User.find(f.user_id)
      user.balance += f.price
      user.save
    end
    redirect_to predictions_path
  end

	def new
		@prediction = Prediction.new
	end

	def create
		@prediction = Prediction.new(prediction_params)
	  if @prediction.save
      flash[:success] =  'Прогноз был успешно добавлен'
   		redirect_to action: 'index'
  	else
      flash[:danger] = 'Возникла ошибка'
      render :new
  	end
  end

    def purchase
=begin
      @prediction = Prediction.find_by_id(params[:id])
  		if current_user.balance >= @prediction.price
  			current_user.balance -= @prediction.price
        current_user.predictions << @prediction
  			if current_user.save
          flash[:success] = 'Прогноз успешно куплен'
  				redirect_to action: 'index'
  			end
  		else
        flash[:danger] = 'Недостаточно средств на балансе для покупки этого прогноза'
  			redirect_to action: 'index'
  		end
=end

      prediction = Prediction.find_by_id(params[:id])
      if Prediction.prediction_purchase(prediction, current_user)
        flash[:success] = 'Прогноз успешно куплен'
        redirect_to action: 'index'
      else
        flash[:danger] = 'Недостаточно средств на балансе для покупки этого прогноза'
        redirect_to action: 'index'
      end

    end

    def destroy
        @prediction = Prediction.find(params[:id]).destroy
        redirect_to action: 'index'
    end


	private
	def prediction_params
      params.require(:prediction).permit(:discipline, :info, :date, :price, :status)
  end

#  def calculate_purchases
#    current_user.purchases.where({created_at: Time.now.midnight..(Time.now.midnight + 1.day) }).count
#  end
end

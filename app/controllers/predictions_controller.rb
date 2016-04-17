class PredictionsController < ApplicationController
	before_action :authenticate_user!
	def index
		@predictions = Prediction.all
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
    end

    def destroy
        @prediction = Prediction.find(params[:id]).destroy
        redirect_to action: 'index'
    end


	private
	def prediction_params
      params.require(:prediction).permit(:discipline, :info, :date, :price, :status)
    end
end

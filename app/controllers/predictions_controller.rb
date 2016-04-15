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

    	respond_to do |format|
    	  	if @prediction.save
       			format.html { redirect_to action: 'index', notice: 'Prediction was successfully created.' }
        		format.json { render :show, status: :created, location: @prediction }
      		else
          		format.html { render :new }
        		format.json { render json: @prediction.errors, status: :unprocessable_entity }
      		end
    	end
    end

    def purchase
    	@prediction = Prediction.find_by_id(params[:id])
    	respond_to do |format|
    		if current_user.balance >= @prediction.price
    			current_user.balance -= @prediction.price
                current_user.predictions << @prediction
    			if current_user.save 
    				format.html { redirect_to action: 'index', notice: 'ok' }
    			end
    		else
    			format.html { redirect_to action: 'index', notice: 'not enough money' }
    		end
    	end
    end

	private
	def prediction_params
      params.require(:prediction).permit(:discipline, :bettype, :info, :date, :price, :status)
    end
end

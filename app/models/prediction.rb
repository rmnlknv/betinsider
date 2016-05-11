class Prediction < ActiveRecord::Base
	has_many :purchases
	has_many :users, through: :purchases

	def self.prediction_purchase(prediction, current_user)
    price = calculate_price(current_user)
	  if current_user.balance >= price
      current_user.balance -= price

      purchase = Purchase.new user_id: current_user.id, prediction_id: prediction.id, price: price
      
      purchase.save
      #current_user.predictions << prediction

      current_user.save ? true : false
    else
      false
    end
	end

  def self.calculate_price(current_user)
    count = current_user.purchases.where({created_at: Time.now.midnight..(Time.now.midnight + 1.day) }).count
    purchases_count = count % 3
    case purchases_count
      when 0
        return 300
      when 1
        return 200
      when 2
        return 100
      else
        return 300
    end
  end

end

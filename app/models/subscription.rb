class Subscription < ActiveRecord::Base
  has_many :subscribes
  has_many :users, through: :subscribes
	
	def self.subscription_purchase(subscription, current_user)
    if current_user.balance >= subscription.price
      current_user.balance -= subscription.price
      current_user.subscriptions << subscription
      current_user.save ? true : false
    else
      false
    end
	end

  def self.subscribed?(current_user)
    if (current_user.subscribes.where(created_at: 7.days.ago..Time.now).any?)
      subscribe = current_user.subscribes.where(created_at: 7.days.ago..Time.now).order(created_at: :desc).first
      subscription = Subscription.find(subscribe.subscription_id)
      if subscription.subtype == "Недельная"
        return Time.at(subscribe.created_at + 7.days)
      end
      if subscription.subtype == "Месячная"
        return Time.at(subscribe.created_at + 1.month)
      end
    end

    if (current_user.subscribes.where(created_at: 1.month.ago..Time.now).any?)
      subscribe = current_user.subscribes.where(created_at: 1.month.ago..Time.now).order(created_at: :desc).first
      subscription = Subscription.find(subscribe.subscription_id)
      if subscription.subtype == "Месячная"
        return Time.at(subscribe.created_at + 1.month)
      end
    end
    return false
  end

       #(current_user.subscribes.where({created_at: 1.month.ago..Time.now}).any?)


  def self.time_remaining(current_user)
    subscribe = current_user.subscribes.where({created_at: 1.month.ago..Time.now}).first
    subscription = Subscription.find(subscribe.subscription_id)
    
    if subscription.subtype = "Недельная"
      return Time.at(subscribe.created_at + 7.days)
    end

    if subcription.subtype = "Месячная"
      return Time.at(subscribe.created_at + 1.month)
    end

    return false
  end

end

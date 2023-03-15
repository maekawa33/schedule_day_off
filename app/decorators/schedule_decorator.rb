class ScheduleDecorator < ApplicationDecorator
  delegate_all

  def total_price
    total_price = 0
    object.events.each do |event|
      total_price += event.price if event.price
    end
    total_price
  end
 
end

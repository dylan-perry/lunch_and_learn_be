require 'rails_helper'

def formatted_datetime(datetime)
    DateTime.new(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min)
end
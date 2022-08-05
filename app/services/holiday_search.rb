class HolidaySearch 
    def holiday_data 
        @all = []
        service.holidays.map do |data|
           @all << HolidayData.new(data)
        end 
    end 

    def next_three_holidays(date)
        @next_three = @all.select do |holiday|
            holiday.date > date
        end 
        @next_three[0..2]
    end 

    def service 
        HolidayService.new 
    end 
end 
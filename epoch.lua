function splitTicks( time_t, time )
	seconds = time % 60
	time = time / 60
	minutes = time % 60
	time = time / 60
	hours = time % 24
	time = time / 24
	
	year = reduceDaysToYear( time )
	month = reduceDaysToMonths( time, year )
	day = math.floor( time )
end

function reduceDaysToYear( time_t, days )
	math.floor( year )
	for year=1970, daysInYear( year ), 1 do
		days = days-daysInYear( year )
	end
	return year
end

function reduceDaysToMonths( time_t, days, math.floor( year ))
	math.floor( month )
	for month=0, daysInMonth( month, year ), 1 do
		days = days-daysInMonth( month, year )
	end
	return month
end

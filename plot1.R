library("data.table")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(getwd(), "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
power <- power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

hist(power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
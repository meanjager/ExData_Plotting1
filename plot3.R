## load the data
setwd("~/Code/JHData/Explore/P1/ExData_Plotting1")
classes <- c("character", "character", "numeric", "numeric", "numeric", 
             "numeric", "numeric", "numeric", "numeric")
powa <- read.table("household_power_consumption.txt", sep=";", header=TRUE, 
                    colClasses = classes, na.strings="?")

## Subset for dates of interest
d1207 <- powa[, "Date"] == "1/2/2007"
d2207 <- powa[, "Date"] == "2/2/2007"
dates <- c(which(d1207), which(d2207))
powaDoI <- powa[dates,]

## convert dates (should I concat in the time?)
##powaDoI[,"Date"] <- as.Date(powaDoI[,"Date"], tz="GMT", 
##                            origin = "1970-01-01", format = "%d/%m/%Y")
## Create consolidated date time column
powaDoI$DateTime <- strptime(paste(as.character(powaDoI[, "Date"]),
                         as.character(powaDoI[, "Time"])), "%d/%m/%Y %H:%M:%S")

## Plot 3

par(mfrow = c(1,1))
plot(powaDoI$DateTime, powaDoI$Sub_metering_1,type="l", xlab = "", 
     ylab = "Energy sub metering", col = "black")
lines(powaDoI$DateTime, powaDoI$Sub_metering_2,col = "red")
lines(powaDoI$DateTime, powaDoI$Sub_metering_3,col = "blue")
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), col = c("black", "red", "blue"), text.width = 55000, 
       cex = .8)

## Copy to a file
dev.copy(png, width = 480, height = 480, "plot3.png")
dev.off()

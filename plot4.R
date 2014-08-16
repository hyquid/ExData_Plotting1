## set the directory to the folder where the "household_power_consumption.txt" is located.

## Read the file in R
a<- read.table("household_power_consumption.txt",na.strings="?",colClasses="character",sep=";",head=T)

## Reformat the date and time
b<- strptime(paste(a$Date,a$Time),"%d/%m/%Y %H:%M:%S")

dat <-cbind(a,b)

dat$Date <- as.Date(dat$Date,"%d/%m/%Y")

## Select the rows with specified dates
part1<-subset(dat,dat$Date=="2007-02-01")
part2<-subset(dat,dat$Date=="2007-02-02")

##combine the two parts into one file
myfile <- rbind(part1,part2)

## setup the 2x2 panel for 4 plots
#par(mfcol = c(2,2))
par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
## make the first plot
plot(myfile$b,myfile$Global_active_power,type="l",xlab = "", ylab = "Global Active Power")

## make the second plot
x <- rep(myfile$b,3)
y <- c(myfile$Sub_metering_1,myfile$Sub_metering_2,myfile$Sub_metering_3)
g <- gl(3,length(myfile$Sub_metering_1), labels = c("Sub_1","Sub_2","Sub_3"))
plot(x,y,type="n",xlab = "", ylab = "Enerby sub metering")
lines(x[g == "Sub_1"],y[g=="Sub_1"])
lines(x[g == "Sub_2"],y[g=="Sub_2"],col="red")
lines(x[g == "Sub_3"],y[g=="Sub_3"],col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n",xjust = 0,cex = 0.7, lty=c(1,1,1),col=c("black","red","blue"))

## make the third plot
plot(myfile$b,myfile$Voltage,type = "l",xlab = "datetime",ylab = "Voltage")

## make the fourth plot
plot(myfile$b,myfile$Global_reactive_power,type = "c",lwd = 0.4,xlab="datetime",ylab="Global_reactive_power")

##copy the plot to png
dev.copy(png,"plot4.png")
dev.off()

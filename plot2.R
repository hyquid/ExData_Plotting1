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

##plot b as x axis and Global_active_power as y axis in a line plot
plot(myfile$b,myfile$Global_active_power,type="l",xlab = "", ylab = "Global Active Power (kilowatts)")

##copy the plot to png
dev.copy(png,"plot2.png")
dev.off()

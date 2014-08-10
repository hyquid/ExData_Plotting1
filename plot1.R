## set the directory to the folder where the "household_power_consumption.txt" is located.

## Read the file in R
a<- read.table("household_power_consumption.txt",na.strings="?",colClasses="character",sep=";",head=T)

## Reformat the date
a$Date <- as.Date(a$Date,"%d/%m/%Y")

## Select the rows with specified dates
part1<-subset(a,a$Date=="2007-02-01")
part2<-subset(a,a$Date=="2007-02-02")

## Test to look at the two parts
head(part1)
head(part2)

##combine the two parts into one file
myfile <- rbind(part1,part2)

## make a vector with the values in myfile$Global_active_power
x <- as.numeric(myfile$Global_active_power)
##make a histogram of x
hist(x,xlab="Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
##copy the plot to png
dev.copy(png,"plot1.png")
dev.off()

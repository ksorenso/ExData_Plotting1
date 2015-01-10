

mainDir <- 'C:/Users/ksorenso.CISCO/Documents/Coursera/eda'
setwd(mainDir)

# create a directory for the plots
dir.create('plots', showWarnings = F)

dataDir <- '/data'
plotDir <- '/plots'

# set the path for the working directory with household_power_consumption.txt
setwd(file.path(mainDir, dataDir))

# sample the first 5 rows and establish the class of each column
d_5 = read.table("household_power_consumption.txt", header=T,sep=";", nrows = 5 , stringsAsFactors = F)
d_classes <- sapply(d_5, class)

# now read in the full table converting '?' to NA
d <- read.table("household_power_consumption.txt", header=T,sep=";", colClasses = d_classes, na.strings = '?')

# convert the data column to a date and select only the rows where the date is between 2/1/07 and 2/2/07
d$asDate <- as.Date(d$Date,'%d/%m/%Y')
ds <- d[(d$asDate == as.Date('2/1/2007','%m/%d/%Y') | d$asDate == as.Date('2/2/2007','%m/%d/%Y')),]

# combine the Date and Time column into one column and create a POSIXlt date/time class
ds$DateTime <- paste(ds$Date,ds$Time)
ds$DateTime <- strptime(ds$DateTime,'%d/%m/%Y  %H:%M:%S')

# tidy up data
ds <- ds[,c('DateTime', names(ds)[3:9])]

# set the working directory for outputting the plot
setwd(file.path(mainDir, plotDir))

png(filename='plot2.png',width=480,height=480,units='px', bg = 'transparent')
plot(ds$DateTime, ds$Global_active_power, ylab = 'Global Active Power (kilowatts)', xlab = '', type='l')
# Close off graphic device
dev.off()





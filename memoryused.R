## estimate the memory required:
##  excel file size unzipped = 129,845KB
##  9 * 2,075,259 rows = 18,677,331 data items
##  now assume 10 bytes per date, 8 bytes per time, 5 per float, 2 per int, 1 per separator
##  ((10 + 8 + 5 + 5 + 5 + 5 + 2 + 2 + 2 + (8*1)) * 2075259)  / (2^20) = 102.9143MB
##  Advanced R by Hadley Wickhame ( Memory ) http://adv-r.had.co.nz/memory.html
##  install.packages("pryr"); library(pryr); mem_used()
## read in the Electric Power Consumption Dataset

## ways to filter on only the wanted dates
## see http://r.789695.n4.nabble.com/How-to-set-a-filter-during-reading-tables-td893857.html
## then https://code.google.com/p/sqldf/
## basically, as of 5/31/2009 the post suggests using Python, Perl or awk or sqldf solution.
## also, you can ignore columns by setting colClasses = c("NULL",rep("numeric",9)) for example

## read in library pryr to be able to do memory usage calculations using mem_used()
library(pryr); 


# set the path for the working directory where the dataset is found
datadir <- "C:/Users/ksorenso.CISCO/Documents/Coursera/eda/data"
setwd(datadir)
d_5 = read.table("household_power_consumption.txt", header=T,sep=";", nrows = 5 , stringsAsFactors = F)
d_classes <- sapply(d_5, class)

memory_before <- mem_used()
d <- read.table("household_power_consumption.txt", header=T,sep=";", colClasses = d_classes, na.strings = '?')
memory_after <- mem_used()
memory_after - memory_before

## 83.8 MB used
## look for rows with NA: d[!complete.cases(d[,]),]

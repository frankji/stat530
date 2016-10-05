# ******>>>>> Dingjue Ji dj333<<<<<******
#
# I worked with * list other students here if applicable *
#
# STAT 230 Homework 2A
# Due Wednesday, September 21, in class, 1 PM
################################################################################
# Chunk of code that should clean up 2013.  Not perfect, needs some help!

filename <- "IndiaAQIraw/aqm2013.csv"

x <- read.csv(filename, as.is=TRUE, header=FALSE)
cinfo <- x[2:3,]

#lines with '24:00 AM' which are not well formatted.
ln<-grep('24:00', x[,1])
#Reformat them into the same way as others
x[ln,1]<-gsub('\\s*24:00\\s*AM\\s*', '', x[ln,1])
x[ln,2]<-'11:59 PM'


#Get rid of the summary at the end of this csv file
#Get the line number first
ln<-grep('[0-9]+/[0-9]+/[0-9]+', x[,1])


title<-sapply(1:ncol(x), function(i) paste(x[1:ln[1]-1,i], collapse = ';'))
col.date<-grep('[Dd][Aa][Tt][Ee]', title, perl = TRUE)
col.time<-grep('[Tt][Ii][Mm][Ee]', title, perl = TRUE)
places<-c("Chennai", "Delhi", "Hyderabad", "Kolkata", "Mumbai")
col.places<-sapply(places, function(x) grep(paste(x,';PM2\\.5_[^_]+;', sep=''), 
                                            title, perl = TRUE))
cols<-c(col.date, col.time, col.places)

x<-x[ln,]
x <- x[,cols]
names(x) <- c("Date", "Time", "Chennai", "Delhi", "Hyderabad", "Kolkata",
              "Mumbai")
head(x)
str(x)



for (i in 3:7) {
  x[,i] <- suppressWarnings(as.numeric(x[,i]))
  x[which(x[,i] < 0), i] <- 0
}

# Now save the processed/cleaned file:
write.table(x, "IndiaPM25/India_PM25_2013.csv", sep=",",
            row.names=FALSE, col.names=TRUE)

# End block of code for 2013: Did you find and fix the problems?
################################################################

################################################################################

filename <- "IndiaAQIraw/aqm2014.csv"

x <- read.csv(filename, as.is=TRUE, header=FALSE)
cinfo <- x[2:3,]

#lines with '24:00 AM' which are not well formatted.
ln<-grep('24:00', x[,1])
#Reformat them into the same way as others
x[ln,1]<-gsub('\\s*24:00\\s*AM\\s*', '', x[ln,1])
x[ln,2]<-'11:59 PM'


#Get rid of the summary at the end of this csv file
#Get the line number first
ln<-grep('[0-9]+/[0-9]+/[0-9]+', x[,1])


title<-sapply(1:ncol(x), function(i) paste(x[1:ln[1]-1,i], collapse = ';'))
col.date<-grep('[Dd][Aa][Tt][Ee]', title, perl = TRUE)
col.time<-grep('[Tt][Ii][Mm][Ee]', title, perl = TRUE)
places<-c("Chennai", "Delhi", "Hyderabad", "Kolkata", "Mumbai")
col.places<-sapply(places, function(x) grep(paste(x,';PM2\\.5_[^_]+;', sep=''), 
                                            title, perl = TRUE))
cols<-c(col.date, col.time, col.places)

x<-x[ln,]
x <- x[,cols]
names(x) <- c("Date", "Time", "Chennai", "Delhi", "Hyderabad", "Kolkata",
              "Mumbai")
#Get rid of weird 'zero' in this dataset
for(i in 3:7){
  x[,i]<-gsub('zero', '0', x[,i])
}
head(x)
str(x)



for (i in 3:7) {
  x[,i] <- suppressWarnings(as.numeric(x[,i]))
  x[which(x[,i] < 0), i] <- 0
}

# Now save the processed/cleaned file:
write.table(x, "IndiaPM25/India_PM25_2014.csv", sep=",",
            row.names=FALSE, col.names=TRUE)
# End block of code for 2014: Did you find and fix the problems?
################################################################

################################################################################
# Chunk of code that should clean up 2015.  Ditto to the above comments.

filename <- "IndiaAQIraw/aqm_jan-nov2015.csv"

x <- read.csv(filename, as.is=TRUE, header=FALSE)
cinfo <- x[2:3,]

#lines with '24:00 AM' which are not well formatted.
ln<-grep('24:00', x[,1])
#Reformat them into the same way as others
x[ln,1]<-gsub('\\s*24:00\\s*AM\\s*', '', x[ln,1])
x[ln,2]<-'11:59 PM'


#Get rid of the summary at the end of this csv file
#Get the line number first
ln<-grep('[0-9]+/[0-9]+/[0-9]+', x[,1])


title<-sapply(1:ncol(x), function(i) paste(x[1:ln[1]-1,i], collapse = ';'))
col.date<-grep('[Dd][Aa][Tt][Ee]', title, perl = TRUE)
col.time<-grep('[Tt][Ii][Mm][Ee]', title, perl = TRUE)
places<-c("Chennai", "Delhi", "Hyderabad", "Kolkata", "Mumbai")
col.places<-sapply(places, function(x) grep(paste(x,';PM2\\.5_[^_]+;', sep=''), 
                                            title, perl = TRUE))
cols<-c(col.date, col.time, col.places)

x<-x[ln,]
x <- x[,cols]
names(x) <- c("Date", "Time", "Chennai", "Delhi", "Hyderabad", "Kolkata",
              "Mumbai")
head(x)
str(x)



for (i in 3:7) {
  x[,i] <- suppressWarnings(as.numeric(x[,i]))
  x[which(x[,i] < 0), i] <- 0
}

# Now save the processed/cleaned file:
write.table(x, "IndiaPM25/India_PM25_2015.csv", sep=",",
            row.names=FALSE, col.names=TRUE)
# End block of code for 2015: Did you find and fix the problems?
################################################################

z <- NULL
for (year in 2013:2015) {
  filename <- paste("IndiaPM25/India_PM25_", year, ".csv", sep="")
  cat("Reading", filename, "-------------\n")
  x <- read.csv(filename, as.is=TRUE)
  print(dim(x))
  print(summary(x$Delhi))
  z <- rbind(z, x)
}

dim(z)

z <- z[,-2]      # We're going to drop the time variable and just use date
z$Date <- as.Date(z$Date, format="%e/%m/%Y")

####################################################################

table(is.na(z$Date))
summary(z$Delhi)
summary(z$Hyderabad)

####################################

### CODE FOR PLOTS HERE:

summary(z[,-1])
par(mfrow=c(1,1))
par(mgp = c(2, 1, 0), font.axis=2)
boxplot(log(z[,-1]), use.col=TRUE,
        xlab = 'Cities', ylab = 'log PM2.5',
        cex.lab=1.2, cex.axis=1)
axis(1, lwd=2, at = seq(1,5), labels=FALSE)
axis(2, lwd=2)

par(mfrow=c(2,3))
for(i in 2:6){
  hist(z[z[,i]<400,i], probability = TRUE,
       xlab='PM2.5', ylab='Density',
       cex.lab=1.2, cex.axis=1, main = paste(
         'PM2.5 at ', colnames(z)[i], sep=''
       ))
  abline(v=median(z[,i], na.rm = TRUE), col='brown1')
}

par(mfrow=c(2,3))
for(i in 2:6){
  plot(z[,i]~z$Date, 
       xlab='Date', ylab='PM2.5', type='l',
       cex.lab=1.2, cex.axis=1, main = paste(
         'PM2.5 at ', colnames(z)[i], sep=''
       ))
}



### END YOUR CODE FOR PLOTS
###
### (1) Which cities appear to have the strongest and weakest seasonal
###     fluctuations?  Give at least one city in the STRONGER and WEAKER
###     category, but list all five below.  That is, you can't call all of them
###     STRONGER, for example!
###
###     STRONGER: Delhi Kolkata
###     WEAKER: Chennal Hyderabad Mumbai
###
### (2) Ask a question about one thing that puzzles you about R thus far.
###     Feel free to provide a specific code example, though realize you
###     may have to present it "commented out" so it doesn't run when you
###     do "compile notebook".  If you don't want to ask a question,
###     just say, "I'm fine with R so far."
###
###     I'm totally cool with R so far.
###     
###
################################################################################

#
# Lecture 6 -- Day of Quiz 1
#
# Homework 2B.  Note that this simulation is designed (a) to get you in the
# spirit of doing simulations, and (b) to better understand natural
# variability in a case like this.  It is neither a hypothesis test nor
# a problem with confidence intervals as it stands, but will be helpful
# to better understand each of these topics.
#
# Homework 2A.

x <- read.csv("merged2A.csv", as.is=TRUE)

# I need the following here, because the CSV file doesn't hold
# the date formatted variable, and the file was created with the
# cleaned up dates from the homework script:
x$Date <- as.Date(x$Date)

# The following plot examples are using the merged data from
# the original Homework 2 script, with no fixes.  So they
# will change once you do the proper fixing and merging.
# Here I just want to give you some code examples to consider,
# steal, modify... you're welcome!

################################################################################
# If the following doesn't work, you will need a larger
# graphics device (on your screen, increase the size of the
# graphics window).  This is close to not working when you
# "compile" the script, but worked in my testing:
par(mfrow=c(3,2)) # 3 rows, 2 columns of graphics in this plot
for (i in 2:6) {
  plot(x[,i] ~ x$Date, xlab="Date", ylab="PM 2.5",
       main=names(x)[i], type="l")
}

# NOTE: the type="l" is a lower-case L and uses lines rather than
# points.  Which you prefer here is a matter of taste I think.


################################################################################
# This is fine in terms of size, but hard to see anything
# useful with the current (incorrect) data:
par(mfrow=c(1,1))   # Accept a single plot
plot(Chennai ~ Date, data=x,
     ylim=range(as.matrix(x[,-1]), na.rm=TRUE))
for (i in 3:6) {
  points(x$Date, x[,i], col=i)
}

################################################################################
# Or an attempt to use two plots perhaps handy for
# exploring time series... though we generally won't
# use formal time series objects unless required for
# a purpose like this (i.e. some function that requires
# them, as in ts.plot):

plot.ts(x[,-1])

ts.plot(as.ts(x$Chennai), as.ts(x$Delhi),
        as.ts(x$Hyderabad), as.ts(x$Kolkata),
        as.ts(x$Mumbai),
        gpars=list(col=1:5))

# Computationally terrible, and it froze my computer
# when I tried it.  So please avoid unless you have
# a smaller data set!
matplot(as.matrix(x[4000:6000, -1]))

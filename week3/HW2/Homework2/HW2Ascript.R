# ******>>>>> YOUR NAME HERE <<<<<******
#
# I worked with * list other students here if applicable *
#
# STAT 230 Homework 2A
# Due Wednesday, September 21, in class, 1 PM
#
# INSTRUCTIONS: See HW2Ainstructions.pdf
#
# THIS SCRIPT: It compiles without modification, but the work done is
# not correct.  You need to fix and add to this script for your homework.
# Do not worry about Date or Time cleaning/manipulation in this top bit of
# code.

################################################################################
# Chunk of code that should clean up 2013.  Not perfect, needs some help!

filename <- "IndiaAQIraw/aqm2013.csv"

# Figure out the columns ordering based on the third row (without looking
# at it in Excel):
x <- read.csv(filename, as.is=TRUE, header=FALSE)
cinfo <- x[2:3,]
cinfo

x <- read.csv(filename, as.is=TRUE, header=FALSE, skip=5)
x <- x[,c(1,2,3,5,7,9,11)]
names(x) <- c("Date", "Time", "Chennai", "Delhi", "Hyderabad", "Kolkata",
              "Mumbai")
head(x)
str(x)

for (i in 3:7) {
  x[,i] <- suppressWarnings(as.numeric(x[,i])) # From Jay to avoid warnings,
                                     # while converting the column to be numeric
  x[which(x[,i] < 0), i] <- 0        # Truncate any negative values to be 0
}

# Now save the processed/cleaned file:
write.table(x, "IndiaPM25/India_PM25_2013.csv", sep=",",
            row.names=FALSE, col.names=TRUE)

# End block of code for 2013: Did you find and fix the problems?
################################################################

################################################################################
# Chunk of code that should clean up 2014.  Not perfect, needs some help!
# I've stripping out some comments here.  If you are unclear about what is
# done, reconsider the same code, above.  But again, don't trust this, it
# isn't perfect!

filename <- "IndiaAQIraw/aqm2014.csv"

x <- read.csv(filename, as.is=TRUE, header=FALSE)
cinfo <- x[3:4,]
cinfo

x <- read.csv(filename, as.is=TRUE, header=FALSE, skip=5)
x <- x[,c(1,2,5,3,11,7,9)]
names(x) <- c("Date", "Time", "Chennai", "Delhi", "Hyderabad", "Kolkata",
              "Mumbai")

for (i in 3:7) {
  x[,i] <- suppressWarnings(as.numeric(x[,i]))
  x[which(x[,i] < 0), i] <- 0
}

write.table(x, "IndiaPM25/India_PM25_2014.csv", sep=",",
            row.names=FALSE, col.names=TRUE)

# End block of code for 2014: Did you find and fix the problems?
################################################################

################################################################################
# Chunk of code that should clean up 2015.  Ditto to the above comments.

filename <- "IndiaAQIraw/aqm_jan-nov2015.csv"

x <- read.csv(filename, as.is=TRUE, header=FALSE)
cinfo <- x[3:4,]
cinfo

x <- read.csv(filename, as.is=TRUE, header=FALSE, skip=5)
x <- x[,c(1,2,4,3,7,5,6)]
names(x) <- c("Date", "Time", "Chennai", "Delhi", "Hyderabad", "Kolkata",
              "Mumbai")

for (i in 3:7) {
  x[,i] <- suppressWarnings(as.numeric(x[,i]))
  x[which(x[,i] < 0), i] <- 0
}

write.table(x, "IndiaPM25/India_PM25_2015.csv", sep=",",
            row.names=FALSE, col.names=TRUE)

# End block of code for 2014: Did you find and fix the problems?
################################################################

###
### Yes, there are problems with what I did immediately above.  The solutions
### aren't that terrible.  In fact, one problem has a trivial fix once you
### notice it.  Another problem or two may not be quite as trivial,
### but are reasonable given what I did in the first part of the script
### and given what I'll have done this week in class.  If you are new to
### programming, this level of difficulty is a step up from Homework 1,
### so get started sooner rather than later.
###

#
# Finally, I'm going to merge these three years of data together.
# Note that at this point I still have problems that haven't been fixed
# in the code above.  But the code that immediately follows is just fine,
# regardless.  That is, once you fix the problems, above, the code below
# may be used without modification.  But if you change something radically,
# above, you might break this workflow.  If that happens, you probably
# did far too much, above, and headed in the wrong direction.
#

z <- NULL
for (year in 2013:2015) {
  filename <- paste("IndiaPM25/India_PM25_", year, ".csv", sep="")
  cat("Reading", filename, "-------------\n")
  x <- read.csv(filename, as.is=TRUE)
  print(dim(x))
  print(summary(x$Delhi))
  z <- rbind(z, x)
}

dim(z) # 25527 rows by 7 columns is the answer *before* fixing my work
# above.  *After* doing the homework the number of rows will change.

z <- z[,-2]      # We're going to drop the time variable and just use date
z$Date <- as.Date(z$Date, format="%e/%m/%Y")

# At this point I'll provide some code which you should leave intact in
# your homework solution.  When you compile the notebook and print your
# homework, the results will be included, obviously.

####################################################################
### Do not delete or change the code immediately below.  It will run
### when the script is compiled, no problem.  

table(is.na(z$Date))
summary(z$Delhi)
summary(z$Hyderabad)

### End "do not delete or change..."
####################################

###
### Your final task here: produce plots to assist in answering the following
### questions.  No formal models or tests or formal statistical inference
### are required or recommended.  Eyeball it from good plots, spending your
### time on "good" plots.

### CODE FOR PLOTS HERE:



### END YOUR CODE FOR PLOTS
###
### (1) Which cities appear to have the strongest and weakest seasonal
###     fluctuations?  Give at least one city in the STRONGER and WEAKER
###     category, but list all five below.  That is, you can't call all of them
###     STRONGER, for example!
###
###     STRONGER:
###     WEAKER:
###
### (2) Ask a question about one thing that puzzles you about R thus far.
###     Feel free to provide a specific code example, though realize you
###     may have to present it "commented out" so it doesn't run when you
###     do "compile notebook".  If you don't want to ask a question,
###     just say, "I'm fine with R so far."
###
###     MAYBE: I'm totally cool with R so far.
###     OR: I'M PUZZLED ABOUT:
###
################################################################################
#
# Done?  Press the "compile notebook" button in R Studio and produce either
# an HTML file or (if you get LaTeX installed) a PDF file.  Check it, make
# sure your name is on it, and print.  Printing this .R script without doing
# "compile notebook" is not sufficient.

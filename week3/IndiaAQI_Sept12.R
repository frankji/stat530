#
# India Air Quality Index (AQI)
# Early explorations
#
# I believe we will have raw PM 2.5 measurements for 2015 and 2016, but
# then PM 2.5 as well as the calculated AQI values for 2013 and 2014.
# Because of this, we'll focus on only the PM 2.5 measurements for this
# in-class work and then on Homework 2.

x <- read.csv("aqm-june-2016.csv", as.is=TRUE, skip=5, header=FALSE)
names(x) <- c("Date", "Time", "Chennai", "Kolkata",
              "Hyderabad", "Mumbai", "Delhi")
dim(x)

# In anticipation of an eventual merge, I'm going to sort the columns
# alphabetically by city.  Make sure you examine, understand, and trust
# this!
head(x)
x <- x[, c("Date", "Time", "Chennai", "Delhi", "Hyderabad", 
           "Kolkata", "Mumbai")]
head(x)

str(x)      # Worrying: our PM 2.5 measurements should be numeric!

# I'll pick on Mumbai here, and until I know what I want to do I'll
# avoid overwriting the columns in our data frame x:
as.numeric(x$Mumbai)

# Pay attention to the warning that results from the line, above!
# This happens when R can't successfully convert something to numeric,
# and you may need to explore before deciding what to do.
# The following single line is absolutely essential for this
# course -- a great example of the core of the language quickly
# helping you translate a "human question" into an "answer":

table(x$Mumbai[is.na(as.numeric(x$Mumbai))])

# There are 10 cases of --- and 60 cases of InVld.
# Now, if I really cared about the difference between InVld
# and ---, I'd need to do something different.
# But at this point, I don't.  If I change my mind later, I'll
# come back to this and will modify the script.  What I'm
# showing you now is an example of the *process* of doing
# data analysis.  It's more than just this example.
# For now, I'm going to accept that by converting things here to
# numeric, some of these entries (like --- and InVld) will be
# denoted by the missing value code, NA.

# Convert all the PM2.5 columns to be numeric.  Again, this one
# example provides something essential for this course.
for (i in 3:7) x[,i] <- as.numeric(x[,i])

# How how do we feel about what we have?
head(x)
tail(x)

table(x$Time)

# Tables can be helpful for doing explorations even when you aren't
# thinking "categorical variable".  Here, I note the very first 30
# shown right before 1:00 AM -- 30 entries seem to be blank.



# Next, I'm going to (try to) fix up the problem that happens at midnight.
# The time at midnight is part of the date field, apparently.
# Fixing this up is very convenient with regular expressions!
x[20:25,]

# In class I'll talk about my choice here of 11:59 PM.  I spent more time
# on this than you probably would believe, relating to the use of special
# objects in R for handling dates and dates/times.
x$Time[grep("24:00 AM", x$Date, fixed=TRUE)] <- "11:59 PM"
x[20:25,]
x$Date <- gsub(" 24:00 AM", "", x$Date, fixed=TRUE)
x[20:25,]


# TAKE THE FOLLOWING WITH A GRAIN OF SALT... STILL WORKING AND THINKING...
# With the following, the trailing F stands for "formatted" just as a
# reminder to me.  The following format requires reading (or skimming)
# options on the help page for ?strptime, which is linked from ?as.Date.

x$DateF <- as.Date(x$Date, format="%e/%m/%Y")
x$DateTimeF <- as.POSIXct(paste(x$Date, x$Time), format="%e/%m/%Y %I:%M %p")

plot(Mumbai ~ DateF, data=x)
plot(Mumbai ~ DateTimeF, data=x)



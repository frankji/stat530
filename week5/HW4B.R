#
# Homework 4B         <<<<<<< Dingjue Ji >>>>>>>>       LAST INITIAL: J
#
# Due Wednesday 10/5, 1 PM
#
# Please staple this behind Homework 4A.  Here, you don't need to
# delete any of the comments -- they aren't excessive.  But please
# don't include any of your exploratory data analysis code & results
# that don't relate directly to the questions posed.  Thanks!

x <- read.csv("http://www.stat.yale.edu/~jay/diving/Diving2000.csv",
              as.is=TRUE)
dim(x)
names(x)

# Most of the variables are obvious.  Country is the country of the diver,
# JCountry is the country of the judge.  There are seven judges for each
# dive.  Be careful: JScore has an odd capitalization and this does matter.
# Rank and DiveNo are used only within rounds of events and should be
# ignored (other than perhaps to observe who eventually won medals).

plot(jitter(JScore) ~ jitter(Difficulty), data=x,
     col=factor(x$Event),
     xlab="Degree of Difficulty",
     ylab="Judge's Scores")
legend("bottomleft", legend=levels(factor(x$Event)),
       pch=1, col=1:nlevels(factor(x$Event)))


# No, the legend isn't beautiful.  But it's fine for basic
# explorations.  It might look just fine on a different
# graphics device, but is kind of bad on my screen at the moment.

# Puzzle: there is an odd left/right division in the plot above.
# I show a few things with graphics which you can observe,
# absorb, and modify for your own use.  There is a lot of overplotting,
# which the jittering partly addresses.  Without use of the jitter()
# the overplotting would have been terrible.  The coloring is a bit of a mess,
# not clearly explaining the left/right groupings (or perhaps it is just
# a gap in the middle).

################################################################################
## Problem 4A.1:
## Using graphical exploration, tables, or other summary statistics,
## try to explain the nature (if any) of the left/right divide
## evident in the plot.  It has nothing to do with the event, I just
## wanted to show you how to add color with an example.

##
## Final code to support your answer here (don't include all
## explorations -- only the essentials).  The code may produce
## a graphic or perhaps graphics, tables, summary statistics, etc...,
## but should related directly to your brief discussion, below.
##

left <- x[x$Difficulty <= 2.1, ]
right <- x[x$Difficulty > 2.1, ]
table(left$Round)
table(right$Round)
plot(jitter(JScore) ~ jitter(Difficulty), data=x,
     col=factor(x$Round),
     xlab="Degree of Difficulty",
     ylab="Judge's Scores")
legend("bottomleft", legend=levels(factor(x$Round)),
       pch=1, col=1:nlevels(factor(x$Round)))





## Tweet out your explanation, or say "I didn't find anything interesting."
## 140 characters or less.  Try it:

# All the divers prefer a low degree (less than 2.2) of difficulty in 
# semi-final. 
#

################################################################################
## Problem 4A.2:
## Calculate some simple summary statistics: a single line of code for
## each challenge, below.  No discussion other than the last challenge.

## What is the average score in the competition?
mean(x$JScore)

## What is the average score for Chinese divers (a single average)?
mean(x[x$Country == 'CHN', 'JScore'])

## What is the average score for American divers (a single average)?
mean(x[x$Country == 'USA', 'JScore'])

## Using tapply(), a one-line command, calculate the average score
## all at once for all countries separately.  Might require some playing
## around and experimenting, but you can check the answers for CHN and USA
## against what you did above.
tapply(x$JScore, factor(x$Country), mean)

## Calculate the Semi-Final average score.  Can you explain why it is
## so much higher than the average score in the Preliminary or Final
## rounds of the competition?  The equivalent of a Tweet or two should
## be more than enough:
mean(x[x$Round == 'Semi', 'JScore'])
tapply(x$JS, factor(x$Round), mean)
mean(x[x$Difficulty <= 2.1, 'JScore'])
mean(x[x$Difficulty > 2.1, 'JScore'])
#
# Because during the Semi, divers are more likely to choose low difficulty.
# When the degree of diffculty is low, it will be easier for divers to get a
# a higher score. As a result, the Semi score will be higher than the others.
#
#


################################################################################
## Problem 4A.3:
##
## Open-ended graphical exploration.  Have some fun exploring the data set
## with graphics.  Choose your favorite -- present it well with labels,
## etc... -- and with the equivalent of a Tweet or two (really, keep it
## short) point out what you find interesting in the plot.  There is no right
## answer, but polish of graphics and code will be noted.  Include only
## your code for the graphic you present.  Use of par(mfrow(...)) is
## allowed as long as the result is clear when printed.

top10 <- sort(tapply(x$JScore, factor(x$Diver), mean), decreasing = TRUE)[1:10]
top10 <- names(top10)
top3 <- top10[1:3]
dat <- x[x$Diver %in% top10, ]
cols <- ifelse(dat$Diver %in% top3, 'red', 'blue')
plot(jitter(JScore) ~ jitter(Difficulty), data=dat,
     col=cols,
     xlab="Degree of Difficulty",
     ylab="Judge's Scores")
legend("bottomleft", legend=c('Top3', 'Top10'),
       pch=1, col=c('red', 'blue'))

# The Top3 divers are distinguished because they can handle the high difficuty
# better.

#
# STAT 230/530 Lecture 3
# Jay Emerson
#
# I just put the following notes up on Piazza.  Which reminds me: Piazza.
#     Sign ip: piazza.com/yale/fall2016/stat230530
#     Use it: piazza.com/yale/fall2016/stat230530/home
#
################################################################################
# Interesting piece.  Math is racist: How data is driving inequality
#
# http://money.cnn.com/2016/09/06/technology/weapons-of-math-destruction/index.html?iid=ob_homepage_tech_pool
#
################################################################################
# Additional getting started comments:
#
# This may only apply to a few of you.  And it tends to be a Windows
# problem (I don't recall this on the Mac).  If your operating
# system (Windows) is set up to use a foreign language, your
# installation of R might sometimes run into troubles with character
# encodings (kind of like fonts) -- things like accents and special
# characters.  My only advice is learn how to switch between
# languages and perhaps Google when you have an error.  This is
# nothing I can reproduce myself, though I'm happy to look at it.
#
# Related to this (and applies to everyone) -- NEVER use MS Word
# to edit a script.  That will definitely result in special characters
# and similar problems.
#
# And finally, NEVER use spaces in file or folder names.  Preferably
# avoid special characters, although I find the underscore _ to be pretty
# reliable.  Some things might work (or might work on some systems),
# but why take the risk?
#
################################################################################
# Business:
#
# - The main page of ClassesV2 is the official record of extra help and
#   business.
# - Discussion sections: undergraduates!  I believe you can start signing
#   up today.  And sections will start this week: 17 Hillhouse Room 03.
#   Note that Section 01 was cancelled and shouldn't be an option.  And
#   Section 04 in my view has no time listed, but is Friday 8:20-9:10am.  If
#   there is demand because of course conflicts, this will become
#   8-8:50am.
# - Discussion section: graduate students.  We'll do an informal poll today.
#   No sign-up is necessary for graduate students.  Not required.
# - Tentative quiz 1 date: Monday, September 19 in class.  On paper only.
# - Tentative quiz 2 date: Monday, October 10 in class.  On paper only.
# - Tentative midterm exam: Wednesday, Nov 2, evening!  You will have 2 hours
#   sometime between 6-11pm and you can choose when to come during this window.
#   Laptops required.
# - In exchange for this unusual midterm exam design, there may not be a
#   formal required class on Monday 10/17 (the week of the Fall Break).  TBD.
# - Final exam date set for Tuesday 12/20, 9am.  Laptops required.
# - There were minor changes to the syllabus (including section participation
#   for undergrads being a minor component of the capstone portion of the
#   grade).
#
################################################################################
# Today:
#
# - A recent CNN poll... and using R to better understand (via simulation)...
# - Exploratory data analysis with basic graphics
# - Some basic data cleaning
#
################################################################################
################################################################################
# A CNN poll appearing 9/6 online and quoted heavily in the media the last
# two days:
#
# http://www.cnn.com/2016/09/06/_politics-zone-injection/trump-vs-clinton-presidential-polls-election-2016/index.html
#
# "Trump tops Clinton 45% to 43% in the new survey, with Libertarian
# Gary Johnson standing at 7% among likely voters in this poll and the
# Green Party's Jill Stein at just 2%."
#
# There were 786 likely voters in the poll.  CNN writes that "the margin of
# sampling error is plus or minus 3.5 percentage points."
#
# Using R as a calculator... figuring that some of these likely voters
# either didn't respond or listed some other candidate?

c(0.45, 0.43, 0.07, 0.02) * 786
354 + 338 + 55 + 16
c(354, 338, 55, 16) / 786

# Basic binomial-type calculations for the proportion of support for Trump
# (aggregating anything "non-Trump" into an aggregate "other" category),
# based on an assumed 354 of 786 responses for Trump:

n <- 786
phat <- 354/n
lb <- phat - 1.96*sqrt(phat*(1-phat)/n)
ub <- phat + 1.96*sqrt(phat*(1-phat)/n)

# 95% confidence interval for proportion of Trump support among likely voters:
round(100*c(lb, ub), 2)          # Scaled to be a percent
1.96*sqrt(phat*(1-phat)/n)       # Margin of error ~ 3.5% is based on this
                                 # very specific notion of 95% confidence.

# We could do the same calculation for Clinton... but in this case we don't
# really have a simply binomial choice for voters.

# Suppose the percent support for the four candidates (Trump, Clinton,
# Johnson, Stein in that order) plus "other" were
probs <- c(0.45, 0.43, 0.07, 0.02, 0.03)
sum(probs)              # Sanity check: probabilities add to 1

# Five random surveys of size 786 from the response probabilities given:
ans <- rmultinom(5, size=n, prob=probs)
apply(ans, 2, sum)      # Sanity check: each column has 786 survey responses!

ans[1,] - ans[2,]       # The difference in votes for Trump minus Clinton,
                        # simulated survey by simulated survey

# My choice of 5, above, was to make it easier to see what was going on.
# We can learn something by doing a much larger simulation, however:

B <- 10000
ans <- rmultinom(B, size=n, prob=probs)
diff <- ans[1,] - ans[2,]
hist(100*diff/n)     # Distribution of our simulated % differences in support.
sum(diff < 0) / B    # Percent of our simulated surveys where Clinton supporters
                     # exceed Trump supporters.  WARNING: this is based on a
                     # very strong assumption of Trump's observed lead in this
                     # one particular national poll!  Buyer beware.

# Or, suppose the race was a dead heat between Trump and Clinton with the
# following probabilities in the population of likely voters:
probs <- c(0.44, 0.44, 0.07, 0.02, 0.03)
ans <- rmultinom(B, size=n, prob=probs)
diff <- ans[1,] - ans[2,]
hist(100*diff/n)
sum( abs(100*diff/n) > 3 ) / B  # Proportion of surveys that would have one
                                # of the two candidates in the lead by more
                                # than 3 percent (and it could be either one).
                                # So basically, anything could be happening,
                                # and yet somehow that's not how CNN reads.


################################################################################
# Temperature and cricket chirps
#
# Source: The Song of Insects by George W. Pierce, 1948, page 20, data on
# the striped ground cricket.  My walk across campus this morning gave me
# the idea.  The web search was harder than I expected.  I'd love a larger
# data set that might include humidity, for example.  And I'm not remotely
# sure that I was hearing crickets this morning, either.

x <- read.csv("cricketchirp.csv", as.is=TRUE)
dim(x)
plot(tempF ~ chirppersec, data = x, pch=19,
     xlab = "CHIRPS PER SOUND",
     ylab = "TEMPERATURE (degrees F)")
plot(chirppersec ~ tempF, data = x, pch=19,
     ylab = "CHIRPS PER SOUND",
     xlab = "TEMPERATURE (degrees F)")
plot(x$tempF, x$chirppersec)

################################################################################
# Air quality in India
#
# Source: \url{http://newdelhi.usembassy.gov/airqualitydata.html}
# About the AQI: \url{http://airnow.gov/index.cfm?action=aqibasics.aqi}
#
# For this class example:        aqm-june-2016.csv
#
# I believe this file has PM2.5 measurements (PM stands for particulate
# matter, 2.5 is the size -- pretty small molecules I understand).
#
# Read in and explore the data set.  Do you trust it?  Keep your eyes open!
# Note below I'm using the object name aq rather than x just to show that
# it's a matter of choice.  I'll mostly use x out of habit, but there is nothing
# sacred about that choice.

aq <- read.csv("http://www.stat.yale.edu/~jay/230/Week2/aqm-june-2016.csv", as.is = TRUE, skip = 5, header = FALSE)
dim(aq)
head(aq)
tail(aq)
str(aq)
names(aq)<-c('Date', 'Time', 'Chennai', 'Kolkata', 'Hyderabad', 'Mumbai', 'Delhi')
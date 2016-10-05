#
# Lecture 7: September 21, 2016
#
# START with clintonresults.pdf.  Motivates most of today's work.
#
# BUSINESS:
# - Quiz 1.  High variance: happens every year.  I don't want you
#   to stress over a low grade, but I do want you to seek help and
#   figure out how to learn in this course.  Thus, if you improve
#   on Quiz 2 I'll use that result in place of Quiz 1.  It's worth
#   noting that loss of points on the first page of questions is
#   very different from loss of points on the latter, non-computational
#   questions.  Two identical scores might contain very different signals.
#   I'll deal with a possible quiz curve only after Quiz 2 is finished.
# - Office hours this week: Thursday 1:30-3pm, lower level of 24 Hillhouse.
# - Office hours normally: Friday 1-2:15 or by appointment, others TBA
#   depending on the week.  HOWEVER: not Friday 9/23.
# - Sunday 9/25: No review session in Mason 211.  I'll do one next
#   Tuesday evening, instead.  However, James will be available as usual.
# - Homework 3 will be posted today, due Wednesday 9/28.
# - Ah yes... Homework 2 is coming back in now.  Almost forgot.
# 
# Here's a toy example of the only really new thing appearing in the
# first code example below.  Here's another example of the
# use of a regular expression -- defining a general pattern
# for the purpose (here) of extracting what we really care
# about.  In this context, \\1 in the replacement string
# refers to the contents of the soft parens () in the search
# string.  [0-9] is a numeric digit, and [0-9]+ means 
# one or more numeric digits.  Finally, the . means "any character"
# and so .* means as many of any character as needed... like
# a wildcard it matches anything.
#
# gsub(): like a very powerful "search and replace"

a <- "blah? BLAH blah Trump 44.5, Clinton 45, blah1 Blah2 3blah"
gsub(".*Trump ([\\.0-9]+).*", "\\1", a)
gsub(".*Clinton ([\\.0-9]+).*", "\\1", a)

as.numeric(gsub(".*Trump ([\\.0-9]+).*", "\\1", a))
as.numeric(gsub(".*Clinton ([\\.0-9]+).*", "\\1", a))

################################################################################
#
# From http://www.realclearpolitics.com
#
## ATTEMPT 1
# This first attempt focuses on the results.  Of course, once
# you realize what it does you'll also realize that there
# is no information about the dates or the states.  The dates
# perhaps are okay to drop... we have the order, anyway.  But
# the state information is critical given the electoral system
# we have here in the US.  However, this is a good starting point
# for trying to understand one way of gathering these data from
# the web.
#
# grep(): go look for matches, and if/when found, give me back the
#         indices (position numbers) of the matches so I know where
#         to find them.
  
file <- "~/Courses/stat530/week4/elections_9_20.html"

x <- scan(file, what="", sep="\n")
x <- x[grep("Trump", x)]
x <- x[grep("lp-results", x)]
x <- gsub("<[^<>]*>", "", x)
trump <- as.numeric(gsub(".*Trump ([\\.0-9]+).*", "\\1", x))
clinton <- as.numeric(gsub(".*Clinton ([\\.0-9]+).*", "\\1", x))
x <- data.frame(trump=trump, clinton=clinton)

## ATTEMPT 2
# Let's try to recover from this, noting by examining the raw
# HTML that 'lp-race' is useful; the results here, z, is a bit
# of a mess but we might be able to recover without much work.
#
# Thus, there are only minor changes below to the chunk above:

x <- scan(file, what="", sep="\n")
x <- x[grep("Trump", x)]
x <- x[grep("lp-results|lp-race", x)]   # | also means "or" here
x <- gsub("<[^<>]*>", "", x)

# Before going on, look carefully about what we have with an alternating
# line pattern in x, above.  This will help explain warnings we are about
# to get, below, that actually aren't a problem here.  Keep your eyes
# open, because in other cases they might indicate a problem!

trump <- as.numeric(gsub(".*Trump ([\\.0-9]+).*", "\\1", x))
clinton <- as.numeric(gsub(".*Clinton ([\\.0-9]+).*", "\\1", x))

state <- gsub(".*\t([^\t]+):.*", "\\1", x)    # Extract the state, which
         # appears sandwiched between a tab and a colon, with as much
         # other stuff before the tab and after the colon as needed to
         # create a match.  Here, [^\t]+ means one or more characters which
         # can be anything but not a tab.

# Anytime you use data.frame where there is (or even might be) character
# data, use the stringsAsFactors = FALSE option at the end.  We don't want
# to mess with factors yet.
x <- data.frame(state=state, trump=trump, clinton=clinton,
                stringsAsFactors = FALSE)

# ATTEMPT 2, continued
# Now let's try to clean it up, because it's close to begin done.

x$state[seq(2, nrow(x), by=2)] <- x$state[seq(1, nrow(x), by=2)]
x <- x[!is.na(x$trump),]

# And scale to exclude other candidate's support:
x[,2:3] <- x[,2:3] / apply(x[,2:3], 1, sum)

#########################
#########################
# Graphical exploration?
#
# Note that below I scale each y-axis to be identical based on the range of
# values from all the polls (not just the polls for each state).  This makes
# better visual comparisons in the resulting file.
#
# The addition of a curve (function loess() for "Local Polynomial
# Regression Fitting") is just to aid in visualizing possible trends
# in cases with 5 or more polls.  Fitting lines wouldn't be that
# satisfying, at least for some of the states we'll look at.
# But as with histograms (where different bin widths
# can change the appearance), controlling the degree of smoothing is a bit
# of an art and not a science.  Opinions may vary as to the appropriate or
# helpful degree of smoothing for a particular problem!

# Let's just look at one state with lots of poll results:
z <- x[x$state=="Virginia",]
z$pollnum <- 1:nrow(z)
plot(clinton ~ pollnum, data=z, pch="C", col="red",
     ylim=range(pretty(x$clinton)),
     main="Virginia", xlab="Poll Results (left side is most recent)",
     ylab="Percent Support for Clinton (Clinton vs. Trump only)")
abline(h=0.5, lty=2)
abline(lm(clinton ~ pollnum, data=z), lwd=2)
ans <- loess(clinton ~ pollnum, data=z, span=1)
lines(predict(ans) ~ z$pollnum, col="red", lwd=2)

######################################################
# Next, let's do this for all states, but only include
# the loess() line when there are at least five poll
# results.  And we'll dump everything to a single
# PDF file.  Don't forget the dev.off() when you do
# this so the PDF file is properly closed.  Failing
# to do this can really confuse things in R Studio.

pdf("clintonresults.pdf")
for (s in unique(x$state)) {
  z <- x[x$state==s,]
  z$pollnum <- 1:nrow(z)
  plot(clinton ~ pollnum, data=z, pch="C", col="red",
       ylim=range(pretty(x$clinton)),
       main=s, xlab="Poll Results (left side is most recent)",
       ylab="Percent Support for Clinton (Clinton vs. Trump only)")
  abline(h=0.5, lty=2)
  if (nrow(z)>=5) {
    abline(lm(clinton ~ pollnum, data=z), lwd=2)
    ans <- loess(clinton ~ pollnum, data=z, span=1)
    lines(predict(ans) ~ z$pollnum, col="red", lwd=2)
  }
}
dev.off()


################################################################################
# A different data source on poll results (creating files for HW3):

baseurl <- 'http://www.electionprojection.com/latest-polls/XXX-presidential-polls-trump-vs-clinton.php'
if (!dir.exists("EP_partlyclean")) dir.create("EP_partlyclean")

for (state in c("ohio", "virginia", "florida", "colorado",
                "minnesota", "nevada", "georgia", "arizona")) {
  thisurl <- gsub("XXX", state, baseurl)
  x <- scan(thisurl, what="", sep="\n")
  x <- x[grep("Clinton \\+|Trump \\+|Tie", x)]
  x <- gsub("<[^<>]*>", ",", x)
  writeLines(x, paste("EP_partlyclean/", state, ".csv", sep=""))
  
  # Seems a little odd to do the following read immediately after a
  # write, but let's consider the benefits:
  x <- read.csv(paste("EP_partlyclean/", state, ".csv", sep=""),
                header=FALSE, as.is=TRUE)
  print(dim(x))    # print() is often needed inside a loop if you really
  # want to print the result of something.  Just putting
  # dim(x) on its own may not display anything.
}


################################################################################
# Homework 2 problem B and more: see the other script, also the basis for HW3.





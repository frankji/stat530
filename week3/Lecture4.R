#
# STAT 230/530 Lecture 4
# 9/12/2016
#
# Business
#
# - Homework 1 should be coming in now on paper, and you should have
#   uploaded at least your script to your dropbox on ClassesV2.  Make
#   sure your names is on the printed version, and if it isn't stapled,
#   please staple in the future.  Lost homework or homework pages aren't
#   much fun for anyone.
# - Homework 2 will be assigned shortly and is due Wednesday, Sept 21.
#   All subsequent homework assignments will be due on Wednesdays (hopefully).
# - Quiz 1 is planned for next Monday, Sept 19, in class and on paper.  I'll
#   say more on Wednesday.
#
################################################################################
# Yale "Yield rate increases" -- a factually correct statement from the YDN

matriculated <- 5500/4
yield <- 0.705
n <- round(matriculated / yield)
1950 - 1375

# Let's assume 1950 students were accepted and 1375 matriculated.  It's in
# the ballpark.  We're ignoring early action/decision, etc... and here
# acting as if each student independently decided to matriculate with
# equal (but unknown) probability.

prop.test(as.table(c(1375, 1950-1375)))
yield - 1.96*sqrt(yield*(1-yield)/n)
yield + 1.96*sqrt(yield*(1-yield)/n)

# Note: the above differ slightly because 1.96 is rounded a little.  And also:
yield
1375 / n

# Our 95% confidence interval for the matriculation probability is
# (0.6845, 0.7249).  This one particular confidence interval may or may
# not include the true unknown probability of a student choosing
# to matriculate.  But the interval was produced using a method that, in
# repeated "good" samples (wild hand-waving here), would result in
# 95% "good" intervals and 5% "misleading" intervals.  Strictly speaking
# we do _not_ say there is a 95% chance that this one interval contains the
# truth.  Once we have it, it's not random, and neither is the truth.
#
# If we took last year's matriculation rate -- which
# according to the YDN was about 0.695 -- a 95% confidence interval based on
# last year's results would have been about (0.675, 0.715).
#
# The observed matriculation rate did increase -- the data prove it beyond a
# doubt.  But the difference is slight and could be attributed to chance rather
# than being tied to some shift in perceptions or preferences.  Unfortunately,
# the implication of such articles is often that something interesting
# happened.  Maybe.  Maybe not!

# A simulation?  Suppose the matriculation probability was 0.7 exactly and that
# 1950 students receive admission.  Other assumptions made here gloss over
# the details of admissions, admittedly, but about how much variation in the
# observed matriculation rate could reasonably be expected?

mat <- rbinom(10000, size=1950, prob=0.7) / 1950
hist(mat, xlab="Simulated Matriculation Rates",
     main="Red: Middle 95% of Simulated Rates; Green: Our 2016 Yale Rate")
abline(v=quantile(mat, c(0.025, 0.975)), col="red", lwd=3)
abline(v=0.705, col="green", lwd=3)


################################################################################
# I'm going to spend time now with the India air quality PM 2.5 data that
# we glanced at last week.  I'll do this in a separate script, however.




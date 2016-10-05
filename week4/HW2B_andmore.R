#
# STAT 230/530 Homework 2B and more
#
# RE: Variability in year-to-year Yale matriculation rates (assuming the
# status quo).  This question is a natural continuation of the simulation
# I conducted on Monday 9/12, based on a good question from one of you
# folks.  Note that I re-uploaded my script after class.
#
# Assume that in each of two consecutive years (say Year 1 and Year 2) Yale
# decides to admit exactly 1950 students who apply to Yale College.
#
# Assume that each student accepts their admission (i.e. they matriculate)
# independently and with the same probability, 0.7.
#
# Conduct a simulation to better understand the extent of the differences
# that could be observed in the matriculation rates of these two years,
# expressed as Year 2 - Year 1.  Note that because of the assumptions made,
# the probability of an increase is the same as the probability of a decrease.
#
# Based on your simulation, provide a 95% region for the difference.
# Produce a histogram showing the simulation results and displaying the
# boundary of this region (it should show values centered at 0).
#
# Your code below should conduct the simulation and produce a single
# graphical display (similar to what I did in class with two green lines).
# Here, you can put a single red line at 0.01 or 1% (depending on the units
# you choose to work with (reflecting our observed increase from 2014 to 2015).
# We suspect that this sort of increase could easily have happened by chance
# and should be "inside" the green boundaries you establish.
#
# CODING HINTS (toy examples for you to explore that might be useful):
#   x <- data.frame(Y1=rnorm(10), Y2=rnorm(10))
#   ans1 <- apply(x, 1, diff)
#   ans2 <- x$Y2 - x$Y1
# Other useful stuff may appear in the section reviews of Thursday and Friday.

B <- 10000
n <- 1950
p <- 0.7
x <- data.frame(Y1 = rbinom(B, n, p), Y2 = rbinom(B, n, p))

# Now convert to proportions and find the difference in proportions
# for each step (row) of the simulated results:
x$phat1 <- x$Y1 / n
x$phat2 <- x$Y2 / n
x$phatdiff <- x$phat1 - x$phat2

# Graphics!
hist(x$phatdiff, xlab="Simulated Difference in Sample Proportions",
     main="Homework 2B Simulation Results",
     breaks=20)
abline(v=quantile(x$phatdiff, c(0.025, 0.975)),
       col="green", lwd=3)
abline(v=0.01, col="red", lwd=3)

####  (((( That was HW2B above -- given the code provided elsewhere, ))))
####  (((( the "challenge" and the importance of the problem lies ))))
####  (((( in the probability and statistical intuition of the simulation. ))))

# Continuing, let's gather (for each step of the simulation) the result
# of a test for the equality of two proportions (using the evidence
# represented by the two sample proportions) as well as the 95%
# confidence interval for the difference in the two proportions.

# ASIDE: using the result of prop.test() as an object in R.  This is
# far more general than just prop.test() and the same idea will apply
# shortly to the use of lm() and more...

ans <- prop.test(c(x$Y1[1], x$Y2[1]), n=c(n,n))
ans
names(ans)
ans$p.value
ans$conf.int

# Let's build this into a loop, filling three new columns with the
# case-by-case p-values and bounds of the confidence intervals:

x$pvalue <- NA; x$confL <- NA; x$confU <- NA
for (i in 1:B) {
  ans <- prop.test(c(x$Y1[i], x$Y2[i]), n=c(n, n))
  x$pvalue[i] <- ans$p.value
  x[i, 7:8] <- ans$conf.int
}
x$confOK <- x$confL<=0 & x$confU>=0
table(x$confOK)
table(x$pvalue <= 0.05)

# The results above may possibly differ by just a very tiny bit
# in this particular case because the data are counts and not
# "continuous".  If we did the exact same exercise with "continuous"
# measurements and t-tests and t-based confidence intervals, they
# would coincide exactly.

# With a little luck (or bad luck) we can look at such an example:
x[x$confOK != (x$pvalue>0.05),]





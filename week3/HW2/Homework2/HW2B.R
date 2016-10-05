#
# STAT 230/530 Homework 2B               NAME:  <<<< YOUR NAME HERE >>>>
#
# Due Wednesday, September 21, 1 PM.  Compile, print, and staple
# *separately* from Homework 2A.  Upload your script to ClassesV2.
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



#
# STAT 230 Homework 2A
# Due Wednesday, September 21, in class, 1 PM
#
# Original data source: http://newdelhi.usembassy.gov/airqualitydata.html
# Unfortunately, the data is sparse for some cities early in 2013.  Equally
# unfortunately, the 2016 data is a mess and only available for a few months.
# So we'll just use 2013-2015.
#
# INSTRUCTIONS:
#
# - Printed and stapled and handed in at the beginning of class: the *compiled*
#   result of your modified HW2Ascript.R.
# - An electronic copy of th R script uploaded to ClassesV2 as insurance
#   *** prior to 1 PM ***.  Something gets lost?  No problem, you have
#   proof of work completed on time.  But our grading is almost entirely
#   on paper.
# - Part of this homework is implicit rather than explicit.  You need to
#   be able to work with the R and R Studio basics.  If you joined the
#   course late there may be some "gotchas" that will slow you down.  Don't
#   leave it for Tuesday night.
#
# Your solution should go into HW2Ascript.R, but read the instructions below
# before starting.  It will likely save you some time.
#
############################################# 80 characters ####################
#
# Uncompress the provided Homework2A.zip file and put it someplace reasonable
# on your computer.  Stay organized.  Windows users, make sure it is
# unzipped!  It won't work from the zip archive (I strongly recommend deleting
# the .zip once you have uncompressed to avoid confusion).
#
# *BEFORE* adding or changing any code in HW2Ascript.R,
# you should be able to "compile notebook" and observe
# the result.  In particular (towards the end) the dim(z) should produce
# 25527 rows and 7 columns.  Call this a sanity check that you are getting
# exactly what I do.  But of course this includes some mistakes and will
# change once you have finished the homework.

###
### Homework 2A: Your first goal is to produce a single data set, z,
### with 3 years of PM 2.5 measurements for the five cities.  
### There are problems with the code I provided and I've left
### this to you to figure out and fix up.
###

# Closing note.  If you get lucky this homework part A may not be terribly time-
# consuming.  However, you are accountable for everything covered in
# various scripts and examples, independently of what is specifically
# required here.  I only say this because I know from past years that
# the second part of the course becomes much easier and more enjoyable
# when students have done steady work beyond the strict requirements in
# the first part of the course.  We would be more than happy to discuss
# things in the help sessions that aren't directly related to the
# homework assignments!


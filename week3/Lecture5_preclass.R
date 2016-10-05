#
# STAT 230/530 Lecture 5
#
# Business
#
# - Quiz Monday, Sept 19 in class.  I post Quiz 1 from Spring 2016
#   to give you an idea of what I did.  At this point (apparently) we'd had
#   discussion of testing and correlation.  Our focus here this
#   term has been a little different.  No guarantees expressed or
#   implied, but I like to use the term "reasonable."
#
# - This is a big class, and might even be called a big introductory class.
#   Don't fall into the trap of treating it as such.  Trying to study at the
#   last minute for the exams will be close to a waste of time.

#   You'll get the most out of the class (with -- frankly -- the least total
#   effort and the most fun) if you throw yourself into it now, doing more
#   than the minumum required from the graded work.  By November you'll be
#   on cruise control and you can coast into the final with few worries and
#   not much of a time commitment. Easy for me to say, I admit!  Feel free
#   to ask Elena, James, or anyone else who has taken the class.
#
# - Homework 2 is posted (problems A and B separately) and due
#   Wednesday, Sept 21.  Follow the instructions, turn in the two parts
#   separately to help us with the grading.
#
# - Section scripts were posted from last week and I'll continue doing the
#   same in the future.  Going through simple examples a line at a time
#   running code, __not just reading code__, can be extremely helpful in
#   getting up to speed.
#
# You could use the following, reading directly from the web:
#x <- read.csv("http://www.stat.yale.edu/~jay/230/Week3/lawsuit.csv",
#              as.is=TRUE)

# Or use the following if you downloaded a local copy of the file:
#x <- read.csv("lawsuit.csv", as.is=TRUE)

# Or... a neat little trick that give me the best of both worlds and
# a chance to show you a conditional statement:
if (file.exists("lawsuit.csv")) {
  x <- read.csv("lawsuit.csv", as.is=TRUE)
} else {
  x <- read.csv("http://www.stat.yale.edu/~jay/230/Week3/lawsuit.csv",
                as.is=TRUE)
}

dim(x)
head(x)
tail(x)

table(x$Type)
mosaicplot(table(x$Type))

table(x$Type, x$Outcome)
mosaicplot(table(x$Type, x$Outcome))  # Recommended

# Alternative usage, not something I feel strongly
# about.  When I do feel strongly about something,
# I'll let you know.
mosaicplot(~ Type + Outcome, data=x) # Okay, fine.
mosaicplot(~ Outcome + Type, data=x) # Yuk

# Really?  This makes no sense to me:
mosaicplot(Outcome ~ Type, data=x)

# This seems backwards!  Crazy.  I should let them know.
mosaicplot(Type ~ Outcome, data=x)

# Aside: a non-trivial mosaicplot of the Titanic data
# included with R (already in a table form):
mosaicplot(Titanic)

################################################################################

table(x$Type, x$Outcome)
summary(table(x$Type, x$Outcome))   # Chi-squared test of "independence"
                                    # same as test for equality of two
                                    # proportions in this simple case, if you
                                    # do prop.test() without the continuity
                                    # correction.
prop.test(table(x$Type, x$Outcome), correct=FALSE)

# But philosophically, the tests above don't reflect the reality of this
# particular case.  This company essentially decided it had to fire 78
# people.  And they did have precisely 11 NewMoms.  That is, the marginal
# counts of this table are fixed in this problem.

################################################################################
# In-class break/challenge.  I'd like to automate the calculation of
# the number of NewMoms fired.  The answer is 8.  This can be done
# directly from the variables in 'x' or from the new object 'temp'
# created immediately below by saving the result of the table()
# function call.  Do it two different ways, and argue with the student
# sitting next to you.
temp <- table(x$Type, x$Outcome)


set.seed(1)
B<-10000
ans<-rep(NA,B)
for(i in 1:B){
  x$SimOutcome <- sample(x$Outcome)
  ans[i] <- sum(x$Type=='NewMom' & x$SimOutcome=='Fired')
}
table(ans)

################################################################################
# Fisher's exact test and the permutation test (which is far more general
# than this one example)

fisher.test(temp)







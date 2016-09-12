# ******>>>>> Dingjue Ji dj333 <<<<<******
#
# I worked with * list other students here if applicable *
#
# STAT 530 Homework 1
# Due Monday, September 12, 9 AM
#
################################################################################
################################################################################

############################################# 80 characters ####################
# PRELIMINARY EXPLORATION
#

x <- read.csv("Zinc.csv", as.is=TRUE)  # Run this line without an error
                                       # before continuing.

# Two groups of rats were given a dietary supplement of calcium (group A) or
# a placebo (group B).  The groups were formed at random. Later, zinc
# concentrations were measured from blood samples, because researchers
# hypothesized that blood zinc levels might be a side effect of a calcium
# dietary supplement.
#
# How large is the data set?  Take a look at the first few cases (rows) and
# the last few cases to see if it looks reasonable.  Sometimes, it doesn't.
# If you get errors, below, then you likely ignored an error, above.
#
# In the area immediately below, provide any code you use for this basic
# exploration.  It won't be graded, but it should be included here for
# completeness and for your own use:

x.dim<-dim(x)
head(x)
tail(x)

# END of your informal exploratory data analysis code.

################################################################################
# Problem A: produce a side-by-side boxplot that illustrates the distribution of
# ZINC measurements broken down by GROUP.  It's a single command (which might be
# broken onto multiple lines because you should make nice axis labels, etc...).
# When you "compile notebook" you'll get the plot for free in the compiled
# report!

# Your code to produce the plot for Problem A:

par(mgp = c(2, 1, 0), font.axis=2)
boxplot(ZINC ~ GROUP, data = x, col = c('brown1', 'cyan3'),
        xlab = 'Group', ylab = 'Zinc', ylim = c(1,1.8),
        cex.lab=1.2, cex.axis=1)
axis(1, lwd=2, at = c(1, 2), labels=FALSE)
axis(2, lwd=2)


# End of Problem A
################################################################################
# Problem B: The following command might be expected
# to produce a scatterplot.  But when run, it produces an error:
#
## > plot(x$ZINC[x$GROUP=="A"], x$ZINC[x$GROUP=="B"])
## Error in xy.coords(x, y, xlabel, ylabel, log) : 
##  'x' and 'y' lengths differ
#
# Special note: if you try to run this plot(...) command in your
# console and got a different error about object 'x' not found,
# then you forgot to interactively read in the data set for exploration
# via the read.csv(...) above.  The "compile notebook" process is run
# separately from your interactive R session in the Console.  Use the
# keyboard shortcuts or copy-paste to do the read.csv(...) in the console.
#
# We're going to ask you to answer two problems on ClassesV2 (as an
# experiment to see if it could save us all time).  But I'll pose
# the main question here.  First, with another student, discuss the error
# shown above with respect to R objects.  Second, for the homework,
# explain the error in the context of this problem
# (rat zinc measurements). This might require playing around just a
# little bit in R.
# 
try(plot(x$ZINC[x$GROUP=="A"], x$ZINC[x$GROUP=="B"]))
# Sample number for A group
length(which(x$GROUP=='A'))
# Sample number for B group
length(which(x$GROUP=='B'))
# t test of two groups
t.test(ZINC~GROUP,data = x)
# End of Problem B
################################################################################
# Problem C: Go find a data set that is (preferably) a CSV file or some other
# nicely-formatted text file.  At this point, it should have variable names
# in the first row with the actual data cases starting in the second row.
# Otherwise, you may have trouble. If it's Excel, save it as CSV.  Put a copy of
# it into your Homework1 folder.  This should be a data set that you at least
# find mildly interesting.  Read the data set into R.  Look at the beginning
# and end (the first and last few rows) to make sure it seems sensible.
# Explore two or three of the variables with things like tables, summary
# statistics, and basic graphics (if all variables are categorical, you should
# investigate the function mosaicplot() in R).  Experiment with R and
# show us that you can manage the basics.

# The expression profile of gene 'scap' in different brain regions and time 
# periods
SCAP<-read.csv(file = 'SCAP_exp.csv', as.is = TRUE)
# Basic data check
dim(SCAP)
names(SCAP)
head(SCAP)
tail(SCAP)
# Data distribution check
sum_SCAP<-summary(SCAP)
mean_SCAP<-as.numeric(gsub('[^0-9\\.]', '', sum_SCAP[4,]))
mean_SCAP
var_SCAP<-apply(SCAP,2,var)
var_SCAP
hist(as.vector(as.matrix(SCAP)), xlab = 'Expression Level',
     breaks=30, main = 'Histogram of Exp')
par(las = 2)
#Function to flatten tables with col & row names
trtab<-function(x, col.name){
  rows<-rownames(x)
  cols<-colnames(x)
  col1<-rep(rows, length(cols))
  col2<-rep(cols, each=length(rows))
  col3<-as.vector(as.matrix(x))
  X<-data.frame(cbind(col1, col2, col3), stringsAsFactors = FALSE)
  colnames(X)<-col.name
  return(X)
}
scap<-trtab(SCAP, c('Time', 'Region', 'Exp'))
# ANOVA for randomized block design
summary(aov(Exp~Time+Region ,data=scap))

boxplot(SCAP, use.cols=TRUE)
# Regions are not clustered by their physical location
heatmap(as.matrix(SCAP), Rowv  = NA)
#Normalize the data by columns
norm_SCAP<-apply(SCAP, 2, function(x) ((x-mean(x))/sd(x)))
# Regions are more likely to be juxtaposed based on location
heatmap(norm_SCAP, Rowv  = NA)
# End of code/discussion for Problem C
################################################################################
#
# Done?  Press the "compile notebook" button in R Studio and produce either
# an HTML file or (if you get LaTeX installed) a PDF file.  Check it, make
# sure your name is on it, and print.  Printing this .R script without doing
# "compile notebook" is not sufficient.





# ******>>>>> Dingjue Ji dj333 <<<<<******
#
# I worked with * list other students here if applicable *
#
# STAT 230 Homework 1
# Due Monday, September 12, 9 AM
#
################################################################################
# INSTRUCTIONS begin here.
#
# AFTER doing the homework and BEFORE "compiling notebook" and printing,
# please DELETE this instruction section.  Save a tree.  (-- 1 point --)
#
# READ & REVIEW: the syllabus and everything posted thus far on
#        http://www.stat.yale.edu/~jay/230/
# In particular, this includes the somewhat lengthy ExtraIntroMaterial.pdf.
# You don't need to be confident at all with the code in this document, but
# you should understand the spirit of what is done.  Parts of the document
# relate directly or indirectly to parts of Homework 1.
#
# - Download a copy of this script to your computer.
# - Download Zinc.csv
# - Put them into a new Homework1 folder.  Stay organized.
# - Edit this document directly in R Studio as you work (never edit scripts
#   in MS Word -- nasty things happen with formatting and special characters)
# - Did you put your name at the top as indicated?
# - You'll write some basic code in this document, including code to
#   produce a plot.  When you do "compile notebook" the plot will be
#   automatically included in a file (likely HTML, but possibly PDF for some
#   of you).  You print that.  You don't print this script itself.
# - You'll need to submit two answers in ClassesV2 in the Tests & Quizzes area.
# - Compile this document!
# - Print and staple, hand in at the beginning of class.
# - An electronic copy of this R script uploaded to ClassesV2 as insurance
#   *** prior to 9 AM ***.  Something gets lost?  No problem, you have
#   proof of work completed on time.  This saved more than a few students
#   last year. (-- 1 point -- awarded for doing this!  So your uploaded file
#   needs to be called 'Homework1.R' with that precise capitalization!)
#
# To be clear -- because this is always a newbie gotcha:  Save this script
# with only the .R extension (don't let your computer name it something
# like Homework1.R.txt, for example) in a folder probably called "Homework1"
# of a class folder (probably called "STAT230").  The same advice regarding
# downloading Zinc.csv applies.  Keep your data analysis life well-organized
# and it will save you time.  Your homework will add to this file, below
# (that is, don't start a new file).
#
# END OF INSTRUCTIONS (delete instructions only once your work is complete,
# but make sure you've completely read and followed the instructions before
# deleting -- with such a large class, organization really matters for us)
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

# Call ggplot2
library('ggplot2')
# Create a plot panel with box plot
mice.box<-ggplot(data = x, aes(x = factor(GROUP), y = ZINC))+
  stat_boxplot(geom = 'errorbar', width = 0.3)+
  geom_boxplot(aes(fill = factor(GROUP)), size=1)
# Add the label and change the theme.
mice.box<-mice.box+xlab('GROUP')+ 
  theme_classic()+theme(text = element_text(size=25))+guides(fill=FALSE)
# Show the figure
mice.box

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

# Gene scoring data from Sfari including top genes related to autism
# and their refenrences and scores
score<-read.csv(file = 'gene-score.csv', header = TRUE)
# Look at the head of it
head(score)
# Look at the tail of it
tail(score)



# End of code/discussion for Problem C
################################################################################
#
# Done?  Press the "compile notebook" button in R Studio and produce either
# an HTML file or (if you get LaTeX installed) a PDF file.  Check it, make
# sure your name is on it, and print.  Printing this .R script without doing
# "compile notebook" is not sufficient.





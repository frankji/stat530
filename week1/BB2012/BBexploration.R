#
# BB2012 Toy exploration in Lecture 2
#
setwd('~/Courses/stat530/week1/BB2012/')
dir()

# The following was a nice idea and would have worked if the file ahd really been a CSV file, but it isn't. Ah well

x <- read.csv("BB2012.csv", as.is = TRUE, header = TRUE, sep=' ')
dim(x)
head(x)

plot(scorediff~pointspread, data = x,
     xlab = "Bookie's Point Speads",
     ylab = "Actural Game Score Differential")

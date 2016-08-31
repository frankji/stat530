# Basic data scrape from Goldsheet
#
# STAT 230/530: I'll use this during shopping period as an example
# of something to work towards.  I hope it helps you answer the question,
# "is this course right for me?"
#
# - If you're thinking, "wow, cool, I'd love to be study problems like
#   this but I'm worried about my computing abilities!" then you are in
#   the right place!
# - If you're thinking something like, "I could do that in Python pretty
#   easily, what's the big deal?" then you're in the wrong place.
# - If you're thinking, "That might be a lot of work and I'm far more
#   interested in the techniques, methods, and theory of data analysis,
#   data mining, and machine learning..." then you're in the wrong place.
#
################################################################################
# In case we have trouble reading from the web, I provide a
# local copy of the page.  The web site also sometimes has slow responses.

#page <- 'http://www.goldsheet.com/historic/cbblog12.html'
#x <- scan(page, what="", sep="\n")   # SLOW!
#length(x)
#write(x, "cbblog12.html")

# Instead, read in from local copy:
setwd('/Users/Frank/Courses/stat530/week1/Hoops/')
x <- scan("cbblog12.html", what="", sep="\n")
length(x)

# First bit of cleaning:
x <- gsub("&#160;", "", x, fixed=TRUE)
x <- gsub("</span>", ",", x, fixed=TRUE)
x <- gsub("<[^<>]*>", "", x)
y <- strsplit(x, ",")

# Sanity check:
table(sapply(y, length))

# More data reduction, tightening the focus:
z <- y[sapply(y, length)==7]
zz <- matrix(unlist(z), ncol=7, byrow=TRUE)

# We're in the home stretch:
scores <- strsplit(zz[,5], "-")
table(sapply(scores, length))
scores <- matrix(as.numeric(unlist(scores)), ncol=2, byrow=TRUE)

ps <- gsub("'", ".5", zz[,4])
ps <- gsub("P", 0, ps)

x <- data.frame(pointspread=as.numeric(ps),
                score1=scores[,1], score2=scores[,2],
                scorediff=scores[,2]-scores[,1],
                loc=zz[,6],
                stringsAsFactors=FALSE)

plot(x$pointspread, x$scorediff,
     xlab="Pre-Game Point Spread",
     ylab="Actual Game Score Differential")
abline(0, 1)

lm.result <- lm(scorediff ~ pointspread, data=x)
abline(lm.result, col="red", lwd=3)
summary(lm.result)

#
# Other very very useful functions for data cleaning and manipulation:
#
# - regexpr()
# - substring()
# - nchar()
# - grep()
# ...
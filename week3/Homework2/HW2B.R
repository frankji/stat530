#
# STAT 230/530 Homework 2B               NAME:  <<<< Dingjue Ji dj333>>>>
#
# Due Wednesday, September 21, 1 PM.  Compile, print, and staple
#####################################################################

x<-data.frame(Y1=rbinom(n = 10000, size=1950, prob = 0.7),
              Y2=rbinom(n = 10000, size=1950, prob = 0.7))
ans1<-apply(x, 1, diff)/1950
q<-quantile(ans1,c(0.025,0.975))
breaks<-hist(ans1,breaks=100, plot=FALSE)$breaks
#Blue area: 95%
#Yellow area: 5%
#Green line: 2.5% and 97.5% quantile
#Red line: 1% difference
histo<-hist(ans1, freq=FALSE, xlab='Rates Difference', breaks=100,
            main='Histogram of Difference',
            col=ifelse(breaks>=q[2] | breaks<=q[1], 'yellow', 'blue'))
abline(v=quantile(ans1,c(0.025,0.975)), col='darkgreen')
abline(v=0.01, col='Brown1')



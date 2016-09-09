#
#EPI data exploration
#

x<-read.csv('EPI_2012_Final_Results.csv', as.is=TRUE)

boxplot(CHMORT ~ EPI_regions, data=x)
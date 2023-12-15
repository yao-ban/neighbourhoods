library(car)
weights <- read.csv("weights3.csv")

weights$Type <- factor(weights$Type)
weights$Link <- factor(weights$Link)
weights$Structure <- factor(weights$Structure)
names <- levels(weights$Type)
codes <- c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","W","Y","V")
linknames <- levels(weights$Link)
structures <- levels(weights$Structure)

#fit varying-slope model by link type for fixed total degree
for (t in 1:20) {
  pdf(paste("td_slope_",names[t],".pdf",sep=""),width=21,height=10.5)

  par(mfrow=c(3,6))
  for (s in 1:3) {
    for (l in 1:6) {
      zslopes <- data.frame()
      for (td in 5:20) {
      	zmodel <- lm(Weight ~ 0 + Degree : Type, data=weights[as.numeric(weights$Link) == l 
      	                                                      & weights$TotalDegree == td 
      	                                                      & as.numeric(weights$Structure) == s,])
      	zslopes <- merge(zslopes, as.data.frame(zmodel$coef), by="row.names", all=TRUE)
      	row.names(zslopes) <- zslopes$Row.names
      }
      zslopes <- zslopes[,-(1:16)]
      plot(5:20,zslopes[t,],main=paste("type =",names[t],", link =",linknames[l],", structure =",structures[s]),
           xlab="Total Degree",ylab="Slope")
    }
  } 
  dev.off()
}

library(car)
weights <- read.csv("neighbourhoods3.csv")

weights$Type <- factor(weights$Type)
weights$Structure <- factor(weights$Structure)
weights$Link <- factor(weights$Link)
names <- levels(weights$Type)
codes <- c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","W","Y","V")
structures <- c("helix","sheet","loop")
links <- c("1D", "2D2", "2D3", "2D4", "3D", "4D")


#By structure and link type
for (i in 1:20) {
  pdf(paste("neighbourhoods_",names[i],".pdf",sep=""),width=7*16/2,height=10.5)
  par(mfrow=c(3,16))
  
  for (s in 1:3){
    for (d in 5:20) {
      tw <- weights[weights$Degree==d 
      				 & as.numeric(weights$Type) == i
      				 & as.numeric(weights$Structure) == s, ]
      plot(aggregate(tw$Frequency,by=list(tw$Weight),FUN=sum), xlab="Weight", ylab="Frequency", main=paste("d =",d,", type =",names[i],", structure = ",structures[s]), xlim=c(0,50), type="l")
      legend("topright", legend=links, col=2:7, lty=1)
      for (l in 1:6) {
      	subw <- weights[weights$Degree==d 
      				 & as.numeric(weights$Type) == i
      				 & as.numeric(weights$Structure) == s
      				 & as.numeric(weights$Link) == l, ]
      	points(aggregate(subw$Frequency,by=list(subw$Weight),FUN=sum), type="l", col=l+1)
      }
    }
  }
  dev.off()
}

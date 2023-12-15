library(car)
library(reshape2)
library(ggplot2)

weights <- read.csv("wholenh.csv")

weights$Type <- factor(weights$Type)
weights$Structure <- factor(weights$Structure)
names <- levels(weights$Type)
codes <- c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","W","Y","V")
structures <- c("helix","sheet","loop")
links <- c("1D", "2D2", "2D3", "2D4", "3D", "4D")

args <- commandArgs(trailingOnly = TRUE)

d <- as.numeric(args[1])
t <- as.numeric(args[2])

for (s in 1:3) {
  subw <- weights[weights$TotalDegree==d & as.numeric(weights$Type) == t & as.numeric(weights$Structure) == s, 2*(1:6)+4]
  subd <- weights[weights$TotalDegree==d & as.numeric(weights$Type) == t & as.numeric(weights$Structure) == s, 2*(1:6)+3]
  subtotal <- apply(subw, 1, sum)
  for (i in 1:dim(subw)[1]) {
    subw[i,] <- subw[i,] / subtotal[i]
  }
  o <- order(subd$X1DDegree,subd$X2D2Degree,subd$X2D3Degree,subd$X2D4Degree,subd$X3DDegree,
             subw$X3DWeight)
  subd <- subd[o,]
  subw <- subw[o,]
  pdf(paste("wholenh_",names[t],"_",structures[s],"_",d,".pdf",sep=""),width=21,height=10.5)
  par(mfrow = c(2,1))
  barplot(t(as.matrix(subw)),col=1:6,border=NA,ylab="Weight",main=paste("type =",names[t],", structure =",structures[s],", degree =",d))
  barplot(t(as.matrix(subd)),col=1:6,border=NA,ylab="Degree",main=paste("type =",names[t],", structure =",structures[s],", degree =",d))
  dev.off()
  
  subw <- weights[weights$TotalDegree==d & as.numeric(weights$Type) == t & as.numeric(weights$Structure) == s, c(2,2*(1:6)+4)]
  pdf(paste("corr_",names[t],"_",structures[s],"_",d,".pdf",sep=""))
  par(mfrow=c(1,1))
  print(ggplot(data = melt(cor(subw)), aes(Var1, Var2, fill=value)) + geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "green", high = "red", midpoint = 0, limit = c(-1,1)) +
    geom_text(aes(Var1, Var2, label=round(value,3)), col="black") +
    ggtitle(paste("type = ",names[t],", structure =",structures[s],", degree =",d)) + xlab("") + ylab(""))
  dev.off()
}


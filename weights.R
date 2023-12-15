library(car)
weights <- read.csv("weights.csv")

weights$Type <- factor(weights$Type)
names <- levels(weights$Type)
codes <- c("A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","W","Y","V")

#log-log model
logmodel <- lm(log(Weight) ~ log(Degree) + Type, data = weights)

i <- 1
pdf(paste("weights_",names[i],".pdf",sep=""))
plot(Weight ~ Degree, pch = as.numeric(Type), col = as.numeric(Type), data = weights[as.numeric(weights$Type) == i,], main=names[i])
curve(exp(logmodel$coef[1]) * x ** (logmodel$coef[2]), col=i, add=T)
dev.off()

for (i in 2:20) {
	pdf(paste("weights_",names[i],".pdf",sep=""))
	plot(Weight ~ Degree, pch = as.numeric(Type), col = as.numeric(Type), data = weights[as.numeric(weights$Type) == i,], main=names[i])
	curve(exp(logmodel$coef[1]+logmodel$coef[i+1]) * x ** (logmodel$coef[2]), col=i, add=T)
	dev.off()
}

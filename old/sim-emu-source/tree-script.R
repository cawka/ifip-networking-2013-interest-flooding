library(ggplot2)
simlog = read.table("final4/tree-iliamo.log")
emulog = read.table("final4/consumer2-longtree.log")
summary(emulog)
summary(simlog)
emulog$V1 = emulog$V1 + 30
summary(emulog)
summary(simlog)
names(emulog) = c("time","nodeid","prefix","packettype","seqnum")
names(simlog) = c("time","nodeid","prefix","packettype","seqnum")
filteredemulog = subset(emulog, packettype == "InData" & prefix == "/good")
filteredsimlog = subset(simlog, packettype == "InData" & prefix == "/good/leaf-3")
summary(emulog)
summary(simlog)
summary(filteredsimlog)
summary(filteredemulog)
filteredemulog$size = 1024
filteredsimlog$size = 1024
filteredemulog$goodput = cumsum(filteredemulog$size)
filteredsimlog$goodput = cumsum(filteredsimlog$size)
filteredemulog$Experiment = "Emulation"
filteredsimlog$Experiment = "Simulation"
filteredsimlog$Experiment = as.factor(filteredsimlog$Experiment)
filteredemulog$Experiment = as.factor(filteredemulog$Experiment)
summary(filteredsimlog)
summary(filteredemulog)
compositlog = rbind(filteredemulog,filteredsimlog)

compositlog = compositlog[sample(1:dim(compositlog)[1],size=500,replace=F),]

plot = ggplot(compositlog) + geom_point(aes(x=time,y=goodput,shape = Experiment)) +scale_shape_manual(values=c(1,3)) + ylab("Total received data (KB)") + xlab("Time (seconds)")
pdf("tree2.pdf")
print(plot)
dev.off()
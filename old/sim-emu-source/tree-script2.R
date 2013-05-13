library(ggplot2)
library(stringr)
library(splancs)
simlog = read.table("final4/tree-iliamo.log")
emulog1 = read.table("final4/attacker2-longtree.log")
emulog2 = read.table("final4/consumer2-longtree.log")

emulog1$V1 = emulog1$V1 + 60
emulog2$V1 = emulog2$V1 + 30

emulog = rbind(emulog1,emulog2)

names(emulog) = c("time","nodeid","prefix","packettype","seqnum")
names(simlog) = c("time","nodeid","prefix","packettype","seqnum")
emulog$Experiment = "Emulation"
simlog$Experiment = "Simulation"
emulog$Experiment = as.factor(emulog$Experiment)
simlog$Experiment = as.factor(simlog$Experiment)

simlog$prefix = str_replace_all(simlog$prefix,"/leaf-0","")
simlog$prefix = str_replace_all(simlog$prefix,"/leaf-1","")
simlog$prefix = str_replace_all(simlog$prefix,"/leaf-2","")
simlog$prefix = str_replace_all(simlog$prefix,"/leaf-3","")

filteredemulog = subset(emulog, packettype == "OutInterest")
filteredemulog = emulog[sample(1:dim(emulog)[1],size=300,replace=F),]

filteredsimlog = subset(simlog, packettype == "OutInterest")
filteredsimlog = simlog[sample(1:dim(simlog)[1],size=300,replace=F),]

composite = rbind(filteredemulog, filteredsimlog)

summary(emulog)
summary(simlog)
summary(filteredsimlog)
summary(filteredemulog)

#compositesample = composite[sample(1:dim(composite)[1],size=00,replace=F),]

plot = ggplot(composite) + geom_point(aes(x=time,y=seqnum,shape = prefix), size =3) + scale_shape_manual(values=c(1,3)) + facet_wrap(~Experiment) + ylab("Transmitted Interests") + xlab("Time (seconds)")

pdf("tree1.pdf")
print(plot)
dev.off()


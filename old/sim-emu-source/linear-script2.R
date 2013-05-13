library(ggplot2)
simlog = read.table("final4/linear-iliamo.log")
emulog1 = read.table("final4/attacker-linear.log")
emulog2 = read.table("final4/consumer-linear.log")

emulog1$V1 = emulog1$V1 + 60
emulog2$V1 = emulog2$V1 + 30

emulog = rbind(emulog1,emulog2)

names(emulog) = c("time","nodeid","prefix","packettype","seqnum")
names(simlog) = c("time","nodeid","prefix","packettype","seqnum")
emulog$experiment = "Emulation"
simlog$experiment = "Simulation"
emulog$experiment = as.factor(emulog$experiment)
simlog$experiment = as.factor(simlog$experiment)

filteredemulog = subset(emulog, packettype == "OutInterest")
filteredsimlog = subset(simlog, packettype == "OutInterest")

composite = rbind(filteredemulog, filteredsimlog)

summary(emulog)
summary(simlog)
summary(filteredsimlog)
summary(filteredemulog)

plot = ggplot(composite) + geom_point(aes(x=time,y=seqnum,shape = prefix)) + facet_wrap(~experiment)

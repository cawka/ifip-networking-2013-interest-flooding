library(ggplot2)
simlog = read.table("final4/linear-iliamo.log")
emulog = read.table("final4/consumer-linear.log")
summary(emulog)
summary(simlog)
emulog$V1 = emulog$V1 + 30
summary(emulog)
summary(simlog)
names(emulog) = c("time","nodeid","prefix","packettype","seqnum")
names(simlog) = c("time","nodeid","prefix","packettype","seqnum")
filteredemulog = subset(emulog, packettype == "InData" & prefix == "/good")
filteredsimlog = subset(simlog, packettype == "InData" & prefix == "/good")
summary(emulog)
summary(simlog)
summary(filteredsimlog)
summary(filteredemulog)
filteredemulog$size = 1024
filteredsimlog$size = 1024
filteredemulog$goodput = cumsum(filteredemulog$size)
filteredsimlog$goodput = cumsum(filteredsimlog$size)
filteredemulog$experiment = "Emulation"
filteredsimlog$experiment = "Simulation"
filteredsimlog$experiment = as.factor(filteredsimlog$experiment)
filteredemulog$experiment = as.factor(filteredemulog$experiment)
summary(filteredsimlog)
summary(filteredemulog)
compositlog = rbind(filteredemulog,filteredsimlog)
plot = ggplot(compositlog) + geom_point(aes(x=time,y=goodput,shape = experiment))
plot
### 7. Virtual sampling with tiles analysis

rm(list=ls())

### Read in reef area names with different abstracted configurations and tile sampling configurations representing different sampling techniques
### TR = Right edge sampling
### TL = Left edge sampling
### TC = Centre sampling
### TRan = Random sampling

quadnames = c("submat_VwTR","submat_VwTL","submat_VwTC","submat_VwTRan", "submat_HwTC","submat_HwTL","submat_HwTR","submat_HwTRan")

### Set hydrodynamic flows
hydrodyms = c("flow","oscillating")

nquads=length(quadnames)

allres=list()

for (quadname in quadnames) for (hydrodym in hydrodyms ) for (rep in 1:5){

### Creates dataframe with counts of larvae settled on tiles
fn = paste("Outputs_tile_sampling/larvlocations_",quadname," ",hydrodym," ",rep,".csv",sep="")
print(fn)
dat=read.csv(fn)
head(dat)
counts = table(dat$sub)
counts2 = rep(0,6)
counts2[as.numeric(names(counts))]=counts

load(quadname)
submat

areas = table(submat)/prod(dim(submat))*100

densities = counts2/areas[2:7]

newrow = data.frame(quadname=quadname,hydrodym=hydrodym,densities=densities,sub=1:6)
allres=rbind(allres,newrow )
}

counts

allres
names(allres)[4]="density"
head(allres)
allres=subset(allres,sub>3)

quadnames
levels(factor(allres$quadname))
myquadnames=c("submat_HwTC","submat_HwTL","submat_HwTR","submat_HwTRan","submat_VwTC","submat_VwTL","submat_VwTR","submat_VwTRan")


### Creates box plot with the number of coral settlers on tiles when using each sampling strategy on each scenario
png("thegraph3.png", width = 480*2, height = 480*2)
par(mfrow=c(2,1))
for (si in 1:2){
thisss = subset(allres,hydrodym == hydrodyms[si] )
boxplot(density~sub*quadname,data=thisss,at=rep(1:3,nquads)+rep(0:(nquads-1),each=3)*5,col=2:4,xaxt="n",xlab="")
title(main=hydrodyms[si])
axis(1,myquadnames,at=1:8*5-3)
}
dev.off()


write.csv(allres, "3settlement_tile_data.csv")

allres = read.csv( "3settlement_tile_data.csv")








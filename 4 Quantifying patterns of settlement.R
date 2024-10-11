### 4. Quantifying spatial patterns of coral settlement within the reef area

quadnames = c("submat_P2", "submat_P1","submat_H","submat_HR","submat_V", "submat_Vdiff2","submat_Vdiff1")
#quadnames = c("submat_HR","submat_V", "submat_Vdiff2","submat_Vdiff1")

hydrodyms = c("cyclo" ,"flow","active","oscillating")

nquads=length(quadnames)

allres=list()

for (quadname in quadnames) for (hydrodym in hydrodyms ) for (rep in 1:5){

### Creates dataframe with counts of larvae that settled on substrates with differing attractiveness within the reef area
fn = paste("Outputs/larvlocations_",quadname," ",hydrodym," ",rep,".csv",sep="")
print(fn)
dat=read.csv(fn)
head(dat)
counts = table(dat$sub)
counts2 = rep(0,3)
counts2[as.numeric(names(counts))]=counts

load(quadname)
submat

### Calculating area of substrates with differing attractiveness within the reef area
areas = table(submat)/prod(dim(submat))*100

### Calculte the density of coral larvae that settled on substrates with differing attractiveness within the reef area
densities = counts2/areas[2:4]

newrow = data.frame(quadname=quadname,hydrodym=hydrodym,densities=densities,sub=1:3)
allres=rbind(allres,newrow )
}

counts

allres
names(allres)[4]="density"
head(allres)

quadnames
levels(factor(thisss$quadname))
myquadnames=c("H","HR","P1","P2","V","Vdiff1","Vdiff2")

### output a boxplot of density of coral larvae that settled on substrates with different atractiveness in each scenario
png("thegraph.png", width = 480*2, height = 480*2)
par(mfrow=c(4,1))
for (si in 1:4){
thisss = subset(allres,hydrodym == hydrodyms[si] )
boxplot(density~sub*quadname,data=thisss,at=rep(1:3,nquads)+rep(0:(nquads-1),each=3)*5,col=2:4,xaxt="n",xlab="")
title(main=hydrodyms[si])
axis(1,myquadnames,at=1:7*5-3)
}
dev.off()

write.csv(allres, "1totalsettlementinreefarea_data.csv")

allres = read.csv( "1totalsettlementinreefarea_data.csv")






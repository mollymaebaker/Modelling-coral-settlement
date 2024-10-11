### 5. Virtual sampling with quadrats

rm(list=ls())

### simulate quadrat sampling for four strategies 
### "centre","left edge","right edge","random" (1,2,3,4)

### Read in reef areas with different abstracted substrate configurations
quadnames = c("submat_P2", "submat_P1","submat_H","submat_HR","submat_V", "submat_Vdiff2","submat_Vdiff1")
#quadnames = c("submat_HR","submat_V", "submat_Vdiff2","submat_Vdiff1")
quadname = "submat_V" #example with vertical substrate configuration

load(quadname)
submat
	
allres=list()

### Select hydrodynamic scenario
hydrodyms = c("cyclo" ,"flow","active","oscillating")
hydrodyms = c("flow","oscillating")#example with unidirectional and oscillating flows

for (hydrodym in hydrodyms){

for (quadstrat in 1:4){

for (rep in 1:5){

### Simulating quadrat sampling
fn = paste("Outputs/larvlocations_",quadname," ",hydrodym," ",rep,".csv",sep="")
print(fn)
dat=read.csv(fn)
head(dat)

if (quadstrat==1) dat$inquad = (dat$x>475 & dat$x<=525 & ((dat$y>475 & dat$y<=525) | (dat$y>775 & dat$y<=825) | (dat$y>175 & dat$y<=225)) )

if (quadstrat==2) dat$inquad = (dat$x>400 & dat$x<=450 & ((dat$y>475 & dat$y<=525) | (dat$y>775 & dat$y<=825) | (dat$y>175 & dat$y<=225)) )

if (quadstrat==3) dat$inquad = (dat$x>550 & dat$x<=600 & ((dat$y>475 & dat$y<=525) | (dat$y>775 & dat$y<=825) | (dat$y>175 & dat$y<=225)) )

if (quadstrat==4) {
xc = runif(3)*150
yc = runif(3)*150
dat$inquad = (
	(dat$x>xc[1]+400 & dat$x<=xc[1]+50+400 & dat$y>yc[1]+100 & dat$y<=yc[1]+50+100) |
	(dat$x>xc[2]+400 & dat$x<=xc[2]+50+400 & dat$y>yc[2]+400 & dat$y<=yc[2]+50+400) |
	(dat$x>xc[3]+400 & dat$x<=xc[3]+50+400 & dat$y>yc[3]+700 & dat$y<=yc[3]+50+700)
	)
}

#image(submat,x=seq(0.5,qs[1]-0.5)/100,y=seq(0.5,qs[2]-0.5)/100,zlim=c(0,3),xlab='',ylab='',xaxt="n",yaxt="n")
with(dat,points(x/100,y/100,col='green',cex=0.2,pch=16))
with(subset(dat,inquad),points(x/100,y/100,col='blue'))

counts = table(subset(dat,inquad)$sub)
counts2 = rep(0,3)
counts2[as.numeric(names(counts))]=counts

newrow = data.frame(quadname=quadname,hydrodym=hydrodym,quadstrat=quadstrat, count=counts2,sub=1:3)
allres=rbind(allres,newrow )
}}}

head(allres)

myquadstratnames=c("centre","left edge","right edge","random")

#creats boxplots with counts of settlers in quadrats placed on each substrate for each scenario
png("thegraph2.png", width = 480*2, height = 480)
par(mfrow=c(2,1))
for (si in 1:2){
thisss = subset(allres,hydrodym == hydrodyms[si] )
boxplot(count~sub*quadstrat,data=thisss,at=rep(1:3,4)+rep(0:(4-1),each=3)*5,col=2:4,xaxt="n",xlab="")
title(main=hydrodyms[si])
axis(1,myquadstratnames,at=1:4*5-3)
}
dev.off()

#This will save a spreadsheet to your working directory (2quadrat_sampling_data.csv) with settler counts in quadrats placed on different substrates for each scenario.scenario
write.csv(allres, "2quadrat_sampling_data.csv")

allres = read.csv( "2quadrat_sampling_data.csv")






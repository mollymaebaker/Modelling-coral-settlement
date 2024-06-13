### 1. Model Functions 

##########################################
print("reading functions")

### Colours representing the attractiveness of different substrates for abstracted substrate configurations
colstouse = c("#f4e4d4","#D4AC7B","#A0D3D7","#1F7AA6")

### Colours representing the attractiveness of different substrates for natural reef substrate configuration of Ningaloo Case Study Site
colstousereal = c("#f5e5d3", "#d4ac7c", "#7bcada", "#1f7aa6", "#552b00")


### Creating the reef area
drawasubmat = function(submat,ifreal=F){
	qs=dim(submat)
	#image(submat,x=seq(0.5,qs[1]-0.5)/100,y=seq(0.5,qs[2]-0.5)/100,zlim=c(0,3),xlab='',ylab='',cex.axis=2)
	if (!ifreal){
		image(submat,x=seq(0.5,qs[1]-0.5)/100,y=seq(0.5,qs[2]-0.5)/100,zlim=c(0,3),
			col=colstouse,xlab='',ylab='',xaxt="n",yaxt="n")
		abline(h=10)
		abline(v=0)
	} else {
		image(submat,x=seq(0.5,qs[1]-0.5)/100,
			y=seq(0.5,qs[2]-0.5)/100,zlim=c(0,4),
			xlab='',ylab='',xaxt="n",yaxt="n",asp=999/1365,bty="n",col=colstousereal )
	}

}

##########################################

### Simulating coral larval settlement

run1simulation = function(quadname,hydrodym,rep,piceverytime=F,prsettdef=c(0,0.01,0.05,0.09,0),ifreal=F ){
load(quadname)
qs=dim(submat)
prsett=prsettdef

### Define larval supply
nlarv=500

#Define reef area size
qs=dim(submat)
settmat = matrix(F,nrow=qs[1],ncol=qs[2])
#image(submat,x=1:qs[1],y=1:qs[2])

##########################################

### Create a random data set of where larvae will be positioned in the matrix in response to different hydrodynamic flows
if (hydrodym=="flow") larv = data.frame(x=runif(nlarv)*qs[1]-qs[1],y=runif(nlarv)*qs[2])
if (hydrodym %in% c("cyclo","active","oscillating")) larv = data.frame(x=runif(nlarv)*qs[1],y=runif(nlarv)*qs[2])

#View(larv)

### Set so larvae are not settled at the beginning of the simulation 
larv$ifsett = FALSE

#with(larv,points(x,y))

### Run simulation
ntimesteps = 3000  
dts = 0.1		## timestep is nominally 0.1 seconds
flowrate = 10 	## cm s-1   ##0.1 ms-1  
turbulence = 5 	## cm s-1  
t=1 
nmove=99

### Hydrodynamic conditions
while (t <=ntimesteps & nmove>0){
  t=t+1
  #### movement

### Unidirectional flow
  if (hydrodym=="flow"){
    nmove = sum(!larv$ifsett) 
    larv$x[!larv$ifsett] = larv$x[!larv$ifsett]+rnorm(nmove)*turbulence*dts +flowrate*dts 
    larv$y[!larv$ifsett] = larv$y[!larv$ifsett]+rnorm(nmove)*turbulence*dts 
    #larv$x =   larv$x%%qs[1] 
    larv$y = larv$y%%qs[2]   
  }

### Oscillating flow
  if (hydrodym=="oscillating"){
    swooshtime = 2 #sec 
    nmove = sum(!larv$ifsett) 
    larv$x[!larv$ifsett] = larv$x[!larv$ifsett]+rnorm(nmove)*turbulence+ flowrate*dts*sin(t*2*pi/(swooshtime/dts))
    larv$y[!larv$ifsett] = larv$y[!larv$ifsett]+rnorm(nmove)*turbulence
    larv$x =   larv$x%%qs[1] 
    larv$y = larv$y%%qs[2]  
  }

### No hydrodynamics
  if (hydrodym=="active"){
    nmove = sum(!larv$ifsett) 
    larv$x[!larv$ifsett] = larv$x[!larv$ifsett]+rnorm(nmove)*turbulence*dts 
    larv$y[!larv$ifsett] = larv$y[!larv$ifsett]+rnorm(nmove)*turbulence*dts 
    larv$x =   larv$x%%qs[1] 
    larv$y = larv$y%%qs[2]   
  }

### Turbulent Cyclonic Eddy
  if (hydrodym=="cyclo"){
    nmove = sum(!larv$ifsett) 
    dx = larv$x[!larv$ifsett] - qs[1]/2 
    dy = larv$y[!larv$ifsett] - qs[2]/2 
    dxx = dy/(qs[1]/2)*flowrate*dts
    dyy = -dx/(qs[1]/2)*flowrate*dts
    larv$x[!larv$ifsett] = larv$x[!larv$ifsett]+rnorm(nmove)*turbulence*dts+dxx 
    larv$y[!larv$ifsett] = larv$y[!larv$ifsett]+rnorm(nmove)*turbulence*dts+dyy 
    larv$x =   larv$x%%qs[1] 
    larv$y = larv$y%%qs[2]   
  }

### Creating visuals
  #image(submat,x=0.5:9.5,y=0.5:9.5,zlim=c(0,3)) 
  #with(larv,points(x,y,col=c('black','red')[ifsett+1],cex=0.5) 
  #with(larv,plot(x,y,col=c('black','red')[ifsett+1],cex=0.5) 
	if (piceverytime & t%%20==0){  ## save every time step T or F
	 	png(paste(dn,quadname,"_",hydrodym,"_",rep,"_",t+ntimesteps,".png",sep=""))
		drawasubmat(submat,ifreal)
		with(larv,points(x/100,y/100,col=c('black','red')[ifsett+1],cex=0.7, pch=19))
		dev.off()
   }

### Settlement
  larv$xi = ceiling(larv$x)
  larv$yi = ceiling(larv$y)
  larv$sub = 0
  larv$inquad = (larv$xi>0 & larv$xi<=qs[1] & larv$yi>0 & larv$yi<=qs[2])
  larv$sub[larv$inquad] = submat[cbind(larv$xi[larv$inquad],larv$yi[larv$inquad] )]
  larv$alreadyocc[larv$inquad] = settmat[cbind(larv$xi[larv$inquad],larv$yi[larv$inquad] )]
  larv$prsett = prsett[larv$sub+1]
  larv$prsett[larv$alreadyocc] = 0
  larv$ifsett = (larv$prsett > runif(nlarv)) | larv$ifsett
  #simualting how larvae will settle
  if (T) {
		settmat[cbind(larv$xi,larv$yi)[larv$ifsett,]]=T
	}
  
  #readline()
  
  
}

### Create file name incorporating substrate configuration (quadname), hydrodynamic scenario and replicate names
fn = paste(quadname,hydrodym,rep)
fn
print(fn)

### Create png file
if (ifreal) png(paste(dn,fn,".png"),width = 480*2, height = 480*2) else png(paste(dn,fn,".png"))
windows()

### Export image of final spatial patterns of settlement across the reef area
drawasubmat(submat,ifreal)
if (!ifreal) with(larv,points(x/100,y/100,col=c('black','red')[ifsett+1],cex=0.7, pch=19))
if (ifreal) with(larv,points(x/100,y/100,col=c('black','red')[ifsett+1],cex=1.4, pch=19))
dev.off()

### Exporting x,y coords of where larvae have settled within the reef area
write.csv(subset(larv,ifsett),paste(dn,"larvlocations_",fn,".csv",sep="")) 

}
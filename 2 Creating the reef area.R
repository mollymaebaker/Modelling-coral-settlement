### 2. Creating the reef area with different abstracted substrate configurations

### Clear environment
rm(list=ls()) 

### source functions
source("1 Functions.R")

### Set reef area size
qs = 1000

### Create matrix with required number of rows and columns to represent reef area
submat = matrix(0,nrow=qs,ncol=qs) 

### Create different abstracted substrate configurations

### Horizontal configuration 1 (H1) 
#######################################################
submat = matrix(0,nrow=qs,ncol=qs) 
submat[100:300,400:600]=1
submat[400:600,400:600]=2
submat[700:900,400:600]=3
image(submat)
save(submat,file="submat_H")

png(paste("submat_H.png"))
drawasubmat(submat)
dev.off()

### Horizontal configuration 2 (H2)
#######################################################
submat = matrix(0,nrow=qs,ncol=qs) 
submat[100:300,400:600]=3
submat[400:600,400:600]=2
submat[700:900,400:600]=1
image(submat)
save(submat,file="submat_HR")

### Vertical cofiguration 1 (V1) 
#######################################################
submat = matrix(0,nrow=qs,ncol=qs) 
submat[100:300,400:600]=1
submat[400:600,400:600]=2
submat[700:900,400:600]=3
submat=t(submat)
image(submat)
save(submat,file="submat_V")

### Vertical configuration 2 (V2) 
#######################################################
submat = matrix(0,nrow=qs,ncol=qs) 
submat[150:250,450:550]=1
submat[400:600,400:600]=2
submat[650:950,350:650]=3
submat=t(submat)
image(submat)
save(submat,file="submat_Vdiff1")

### Vertical configuration 3 (V3)
####################################################### 
submat = matrix(0,nrow=qs,ncol=qs) 
submat[150:250,450:550]=3
submat[400:600,400:600]=2
submat[650:950,350:650]=1
submat=t(submat)
image(submat)
save(submat,file="submat_Vdiff2")

### Patchy cofiguration 1 (P1)
#######################################################
ss=sample(rep(1:3,12)) 
submat = matrix(0,nrow=qs,ncol=qs)
bs=58 
bsep = round(qs[1]/6)-1
ii=0
for (i in 1:6) for (j in 1:6) {
ii=ii+1
 sx = 50+(i-1)*bsep
 sy = 50+(j-1)*bsep
 submat[sx:(sx+bs),sy:(sy+bs)]=ss[ii]
}
image(submat)
save(submat,file="submat_P1")
table(submat)

### Patchy configuration 2 (P2)
#######################################################
ss=sample(rep(1:3,12))
submat = matrix(0,nrow=qs,ncol=qs)
bs=58 
bsep = round(qs[1]/6)-1
ii=0
for (i in 1:6) for (j in 1:6) {
ii=ii+1
 sx = 50+(i-1)*bsep
 sy = 50+(j-1)*bsep
 submat[sx:(sx+bs),sy:(sy+bs)]=ss[ii]
}
image(submat)
save(submat,file="submat_P2")
table(submat)

### Vertical configuration 1 (V1) with settlement tiles
#######################################################
submat = matrix(0,nrow=qs,ncol=qs) 
submat[100:300,400:600]=1
submat[400:600,400:600]=2
submat[700:900,400:600]=3
image(submat)

### Centre Sampling
submat1 = submat
for (i in 0:4) submat[(115:125)+(i*40),495:505]=4
for (i in 0:4) submat[(115:125)+(i*40)+300,495:505]=5
for (i in 0:4) submat[(115:125)+(i*40)+600,495:505]=6
submat=t(submat)
image(submat)
save(submat,file="submat_VwTC")
png(paste("submat_VwTC.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Left Edge Sampling
for (i in 0:4) submat[(115:125)+(i*40),(495:505)-90]=4
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)-90]=5
for (i in 0:4) submat[(115:125)+(i*40)+600,(495:505)-90]=6
submat=t(submat)
image(submat)
save(submat,file="submat_VwTL")
png(paste("submat_VwTL.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Right Edge Sampling
for (i in 0:4) submat[(115:125)+(i*40),(495:505)+90]=4
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)+90]=5
for (i in 0:4) submat[(115:125)+(i*40)+600,(495:505)+90]=6
submat=t(submat)
image(submat)
save(submat,file="submat_VwTR")
png(paste("submat_VwTR.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Random Sampling
for (i in 0:4) {
	p1=sample(1:190,1)
	p2=sample(1:190,1)
	submat[(p1:(p1+10))+100 ,(p2:(p2+10))+400]=4
}
for (i in 0:4) {
	p1=sample(1:190,1)
	p2=sample(1:190,1)
	submat[(p1:(p1+10))+400 ,(p2:(p2+10))+400]=5
}
for (i in 0:4) {
	p1=sample(1:190,1)
	p2=sample(1:190,1)
	submat[(p1:(p1+10))+700 ,(p2:(p2+10))+400]=6
}
submat=t(submat)
image(submat1)
save(submat,file="submat_VwTRan")
png(paste("submat_VwTRan.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Horizontal configuration 2 (H2) with settlement tiles
#######################################################
submat = matrix(0,nrow=qs,ncol=qs) 
submat[100:300,400:600]=3
submat[400:600,400:600]=2
submat[700:900,400:600]=1
submat=t(submat) 
image(submat)


### Centre Sampling
submat1 = submat
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)-300]=6
for (i in 0:4) submat[(115:125)+(i*40)+300,495:505]=5
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)+300]=4
submat=t(submat)
image(submat)
save(submat,file="submat_HwTC")
png(paste("submat_HwTC.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Left Edge Sampling
submat1 = submat
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)-390]=6
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)-90]=5
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)+210]=4
submat=t(submat)
image(submat)
save(submat,file="submat_HwTL")
png(paste("submat_HwTL.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Right Edge Sampling
submat1 = submat
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)-210]=6
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505) +90]=5
for (i in 0:4) submat[(115:125)+(i*40)+300,(495:505)+390]=4
submat=t(submat)
image(submat)
save(submat,file="submat_HwTR")
png(paste("submat_HwTR.png"))
drawasubmat(submat)
dev.off()
submat = submat1

### Random Sampling 
for (i in 0:4) {
	p1=sample(1:190,1)
	p2=sample(1:190,1)
	submat[(p1:(p1+10))+400 ,(p2:(p2+10))+100]=6
}
for (i in 0:4) {
	p1=sample(1:190,1)
	p2=sample(1:190,1)
	submat[(p1:(p1+10))+400 ,(p2:(p2+10))+400]=5
}
for (i in 0:4) {
	p1=sample(1:190,1)
	p2=sample(1:190,1)
	submat[(p1:(p1+10))+400 ,(p2:(p2+10))+700]=4
}
submat=t(submat)
image(submat)
save(submat,file="submat_HwTRan")
png(paste("submat_HwTRan.png"))
drawasubmat(submat)
dev.off()
submat = submat1


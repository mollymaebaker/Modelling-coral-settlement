
##### 10. Case study sampling

rm(list=ls())
source("1 Functions.R")
### Load in orthomosaic of case study site
quadnames = c("Real_Mosaic")


### Select hyrodynamic condition
hydrodyms = c("flow")

nquads=length(quadnames)

allres=list()

for (quadname in quadnames) for (hydrodym in hydrodyms ) for (rep in 1:5){

### Creates dataframe with counts of larvae settled on each substrate
fn = paste("Outputs_application/larvlocations_",quadname," ",hydrodym," ",rep,".csv",sep="")
print(fn)
dat=read.csv(fn)
head(dat)
counts = table(dat$sub)
counts=c(0,0,counts)

load(quadname)
submat

### Calculating areas of each substrate type

areas = table(submat)/prod(dim(submat))*100

### Calculate density of coral larvae that settled on each substrate type
densities = counts/areas

newrow = data.frame(quadname=quadname,hydrodym=hydrodym,densities=densities,counts=counts,sub=1:5)
allres=rbind(allres,newrow )
}

write.csv(allres, "4case_study_data.csv")
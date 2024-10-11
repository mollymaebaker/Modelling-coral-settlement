### 3. Simulating Coral Larval Settlement for different scenarios
rm(list=ls())

source("1 Functions.R")

### Read in reef areas with different abstracted substrate configurations
quadnames = c("submat_P1", "submat_P2", "submat_H","submat_HR","submat_V","submat_Vdiff2","submat_Vdiff1")

for (quadname in quadnames ){

### Number of replicates to be run for each scenario
for (rep in 1:5){

### File location for outputs
dn = "Outputs/"

### Read in different hyrdoynamic scenarios
hydrodyms = c("cyclo" ,"flow","active","oscillating")

for (hydrodym in hydrodyms){
	run1simulation(quadname,hydrodym,rep,piceverytime=F)
}}}


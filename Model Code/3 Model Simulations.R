### 3. Simulating Coral Larval Settlement

rm(list=ls())

source("1 Functions.R")

### Read in reef areas with different abstracted substrate configurations
quadnames = c("submat_P1", "submat_P2", "submat_H","submat_HR","submat_V","submat_Vdiff2","submat_Vdiff1")
#quadnames = c("submat_H")

for (quadname in quadnames ){

### Number of replicates to be run for each scenario
for (rep in 1:2){

### File location for outputs
dn = "Outputs/"

### Set hydrodynamic condition you want to simulate

### Cyclonic Eddy
#hydrodym = "cyclo" 

### Unidirectional Flow
#hydrodym = "flow" 

### No hydrodynamics
#hydrodym = "active"

### Osciallting flow
#hydrodym = "oscillating" 

hydrodyms = c("cyclo" ,"flow","active","oscillating")
hydrodym = "oscillating"

for (hydrodym in hydrodyms){
	run1simulation(quadname,hydrodym,rep,piceverytime=F)
}}}


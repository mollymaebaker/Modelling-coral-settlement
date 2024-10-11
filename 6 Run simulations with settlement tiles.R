### 6. Run simulations with settlement tiles

### Run tile sampling simulations
source("1 Functions.R")

### Read in reef area names with different abstracted configurations and tile sampling configurations representing different sampling strategies
quadnames = c("submat_VwTR","submat_VwTL","submat_VwTC","submat_VwTRan", "submat_HwTC","submat_HwTL", "submat_HwTR","submat_HwTRan")

for (quadname in quadnames ){

### Decide on the number of replicates you want to run for each scenario
for (rep in 1:5){

### File location
dn = "Outputs_tile_sampling/"

### Set hydrodynamic flow you want to simulate
#hydrodym = "cyclo" #anticyclonic eddy driving larvae down to the substrate
#hydrodym = "flow" #horizontal flow from left the right
#hydrodym = "active" #active larval settlement (representing larvae reaching developmental competency)
#hydrodym = "oscillating" #oscillating flow from left the right

hydrodyms = c("flow","oscillating")

### Run simulation
for (hydrodym in hydrodyms){
	run1simulation(quadname,hydrodym,rep,prsettdef=c(0,0.01,0.05,0.09,0.99,0.99,0.99),piceverytime=F)
}}}





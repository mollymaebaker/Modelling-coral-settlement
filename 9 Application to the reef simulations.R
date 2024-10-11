### 9. Applying the model to a case study site - simulations

rm(list=ls())
source("1 Functions.R")

### Input mosaic of natural reef substrate configuration
quadname = "Real_mosaic" 

### Set file location for outputs
dn = "Outputs_application/"

### Set hydrodynamic regime you want to simulate across case study site
#hydrodym = "cyclo" #anticyclonic eddy driving larvae down to the substrate
#hydrodym = "flow" #horizontal flow from left the right
#hydrodym = "active" #active larval settlement (representing larvae reaching developmental competency)
#hydrodym = "oscillating" #oscillating flow from left the right
hydrodym = "flow"

### Simulate settlement for 5 reps
for (rep in 1:5){


### Probabilities of settlement on different substrates
prsett = c(0,0,0.03,0.07,0.09) 

### Run simulation - this will save output pngs (showing the distribution of coral settlers at the end of each simulation)
### and csv files (with the coordinates of settlers within the reef mosaic) to the subfolder 'Outputs_application'
run1simulation(quadname,hydrodym,rep,piceverytime=F,prsettdef=prsett,ifreal=T )

}




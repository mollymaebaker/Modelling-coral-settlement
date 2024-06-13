### 9. Applying the model to a case study site - simulations

rm(list=ls())
source("1 Functions.R")

### Input mosaics of naturall reef substrate configuration
quadname = "Real_mosaic" 

### Set file location for outputs
dn = "High qual/"

### Set hydrodynamic regime you want to simulate across case study site
#hydrodym = "cyclo" #anticyclonic eddy driving larvae down to the substrate
#hydrodym = "flow" #horizontal flow from left the right
#hydrodym = "active" #active larval settlement (representing larvae reaching developmental competency)
#hydrodym = "oscillating" #oscillating flow from left the right

hydrodym = "flow"
rep = 1

prsett = c(0,0,0.03,0.07,0.09) 

### Run simulation
run1simulation(quadname,hydrodym,rep,piceverytime=F,prsettdef=prsett,ifreal=T )
read.csv()
citation()




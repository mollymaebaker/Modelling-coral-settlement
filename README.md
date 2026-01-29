# Modelling interactive effects of biological and environmental factors on fine-scale coral settlement patterns

## Model Overview
This mechanistic simulation model was developed to explore how three overarching factors — (1) the attractiveness of reef substrates, (2) local hydrodynamics and (3) the spatial distribution of reef substrates — might interact to influence fine-scale (centimetres to metres) spatial patterns of coral larval settlement. Through scenario exploration, we found that interactions among these three factors can lead to contrasting, and sometimes counterintuitive, spatial patterns of settlement. By simulating common field survey methods (settlement tiles and quadrat sampling) we show that interactions among biological and environmental factors could lead to incorrect conclusions, regarding, for example, the substrates larvae prefer for settlement. Lastly, with a case study from Ningaloo Reef, Western Australia, we illustrate how the model can help explore mechanisms underlying patterns of settlement within complex benthic landscapes and highlight key gaps in knowledge for future empirical research.

For more information see https://www.sciencedirect.com/science/article/pii/S0304380025000237#sec0002

## Factors included in the model:

### 1 | Substrate attractiveness

Not attractive: Substrate has a 0.00 probability of settlement at each time step.

Low attractiveness: Substrate has a 0.01 probability of settlement at each time step.

Medium attractiveness: Substrate has a 0.05 probability of settlement at each time step.

High attractiveness: Substrate has a 0.09 probability of settlement at each time step.

### 2 | Substrate configuration

a) Horizontal-1 (H1): Horizontal alignment of three substrates with differing attractiveness (low, medium, and high) of the same size (4 m2).

b) Horizontal-2 (H2): Horizontal alignment of three substrates with differing attractiveness (low, medium, and high) of the same size (4 m2) in the reversed order to the horizontal-1 configuration.

c) Vertical-1 (V1): Vertical alignment of three substrates with differing attractiveness (low, medium, and high) of the same size (4 m2).

d) Vertical-2 (V2): Vertical alignment of three substrates with differing attractiveness (low, medium, and high) of different sizes (1 m2, 4 m2, 9 m2, respectively). Substrates with a greater attractiveness are larger in size.

e) Vertical-3 (V3): Vertical alignment of substrates with differing attractiveness (low, medium, and high) of different sizes (9 m2, 4 m2, 1 m2, respectively). Substrates with a greater attractiveness are smaller in size.

f) Patchy-1 (P1): Patchy distribution of substrates with 36 patches of the same size (0.36 m2). Each patch was randomly assigned a substrate attractiveness of 0.01, 0.05 or 0.09 resulting in 12 patches of each attractiveness.

g) Patchy-2 (P2): Patchy distribution of substrates with 36 patches of the same size (0.36 m2). Each patch was randomly assigned a substrate attractiveness of 0.01, 0.05 or 0.09 resulting in 12 patches of each attractiveness, different to patchy-1.

  ![1-s2 0-S0304380025000237-gr1_lrg](https://github.com/user-attachments/assets/2888b359-65b6-4c8c-a013-4413fa951882)

### 3 | Local hydrodynamics

a) Unidirectional flow: Larvae are transported in the horizontal direction from the left side to the right side of the reef area. The reef area is not wrapped in the direction of flow, therefore larvae that have not settled and leave the reef area do not return.

b) Oscillating flow: Larvae are transported back and forth (right to left) within the reef area. The reef area is wrapped, retaining larvae until the simulation ends.

c) Cyclonic eddy: Larvae are transported in a clockwise motion around the reef area. The reef area is wrapped, retaining larvae until the simulation ends.

d) No hydrodynamics: No hydrodynamics acting on larvae. The reef area is wrapped, retaining larvae until the simulation ends.

Additional random, fine-scale movements, representing fine-scale turbulence and/or exploration of the substrates by larvae are incorporated in all hydrodynamic scenarios.

![Alt text](gifs/Hydrodynamics.gif)

## Virtual sampling

To explore how in-situ sampling designs using common methods (quadrats (a) and settlement tiles (b)) for sampling larval supply, settlement and recruitment are affected by interactions among substrate attractiveness, local hydrodynamics, and substrate configuration, we virtually sampled coral settlers in model outputs.

![1-s2 0-S0304380025000237-gr2_lrg](https://github.com/user-attachments/assets/b72630b3-bdfb-472b-a82b-917cfdc366d5)

## Application to the reef
To demonstrate the applicability of our model to natural reef environments that are often typified by complex patchworks of different substrates, we ran the model for a case study site from Ningaloo Reef, Western Australia.

![Alt text](gifs/Modelling_coral_larval_settlement.gif)

## Instructions for use
- Reading the paper 'Modelling interactive effects of biological and environmental factors on fine-scale coral settlement patterns' (insert link here) is suggested before using the code provided. Running the following code should produce ouputs similar to examples shown in Video B.1, Video B.2 and Video B.3 (to view you will need to download the mp4 files).

- Make sure all the scripts and the 'Real_mosaic.png' are downloaded to a single directory/folder.

- Create an empty subfolder called 'Outputs'

- Create another empty subfolder called 'Outputs_tile_sampling'

- Create another empty subfolder called 'Outputs_application'

- Open R and set the working directory to where the scripts, 'Real_mosaic.png' and subfolders and are saved.

- No need to run script '1 Functions.R' as this is pulled into other scripts.

- Run script '2 Creating the reef area.R' to create reef areas with different substrate configurations.

- Make sure each substrate configuration/submat has saved to the working directory before moving onto script '3 Model Simulations.R'

- Run '3 Model Simulations.R' to run simulations for each sceanrio. This will output a png (showing the distribution of coral settlers at the end of each simulation)
and a csv file (with the coordinates of where larvae settled within the reef area ) for each scenario in the 'Outputs' subfolder.

- Running '4 Quantifying patterns of settlement.R' will ouput a csv file (1totalsettlementinreefarea_data.csv) into the working directory with counts/densitites for the number of larvae that settled on different substrates
within the reef area for each scenario. In this file the column 'sub' represents the attractiveness of different substrates where '1'=low, '2'=medium and '3'=high.

- Run '5 Virtual sampling with quadrats' to simulate different strategies of sampling coral settlers with quadrats for two example scenarios:
1) Vertical substrate configuration with unidirectional flow
2) Vertical substrate configuration with oscillating flow

- This will output a csv file to your working directory (2quadrat_sampling_data.csv) with settler counts in quadrats placed on different substrates for each scenario.
The column 'quadstrat' represents the sampling technique used with quadrats:
'1'=centre, '2'=left edge, '3'=right edge, '4'=random.

- Run '6 Run simulations with settlement tiles' to rerun simulations with different settlement tile configurations (representing different strategies of sampling with tiles) for four example scenarios:
1) Vertical substrate configuration with unidirectional flow
2) Vertical substrate configuration with oscillating flow
3) Horizontal substrate configuration with unidirectional flow
4) Horizontal substrate configuration with oscillating flow
   
- This will output a png (showing the distribution of coral settlers at the end of each simulation) and a csv file (with the coordinates where larvae settled within the reef area) for each scenario to the 'Outputs_tile_sampling' subfolder.

- Run '7 Virtual Sampling Tiles Analysis' to get a dataframe with the number of larvae that settled on tiles for each sampling strategy for each scenario.
This will save a spreadsheet to your working directory (3tile_sampling_data.csv).
The column 'sub' represents the attractiveness of different substrates where
'4'=low, '5'=medium and '6'=high.

- Run '8 Application to the reef.R' to upload reef 2D mosaic, to assign different substrate types and settlement probabilities prior to simulation.

- Run '9 Application to the reef simulations.R' to simulate settlement on the reef 2D mosaic.

- Run '10 Application to the reef sampling' to create a csv file with the counts/densities of coral settlers on each substrate type within the reef 2D mosaic. The column 'sub' represents the different substrates where
'1'=sand, '2'= live coral, '3'=rubble, '4' =dead staghorn coral , '5'=dead coral (other).

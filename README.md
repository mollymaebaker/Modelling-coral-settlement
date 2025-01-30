This model was developed to explore how three overarching factors — (1) the attractiveness of reef substrates, (2) local hydrodynamics and (3) the spatial distribution of reef substrates — might interact to influence fine-scale (metres) spatial patterns of settlement. Through scenario exploration, we found that interactions among these three factors can lead to contrasting, and sometimes counterintuitive, spatial patterns of settlement. By simulating common field survey methods (settlement tiles and quadrat sampling) we show that interactions among biological and environmental factors could lead to incorrect conclusions, regarding, for example, the substrates larvae prefer for settlement. Lastly, with a case study from Ningaloo Reef, Western Australia, we illustrate how the model can help explore mechanisms underlying patterns of settlement within complex benthic landscapes and highlight key gaps in knowledge for future empirical research.

Reading the paper 'Modelling interactive effects of biological and environmental factors on fine-scale coral settlement patterns' (insert link here) is suggested before using the code provided.

Make sure all the scripts and the 'Real_mosaic.png' are downloaded to a single directory/folder.

Create an empty subfolder called 'Outputs'

Create another empty subfolder called 'Outputs_tile_sampling'

Create another empty subfolder called 'Outputs_application'

Open R and set the working directory to where the scripts, 'Real_mosaic.png' and subfolders and are saved.

No need to run script '1 Functions.R' as this is pulled into other scripts.

Run script '2 Creating the reef area.R' to create reef areas with different substrate configurations.

Make sure each substrate configuration/submat has saved to the working directory before moving onto script '3 Model Simulations.R'

Run '3 Model Simulations.R' to run simulations for each sceanrio. This will output a png (showing the distribution of coral settlers at the end of each simulation)
and a csv file (with the coordinates of where larvae settled within the reef area ) for each scenario in the 'Outputs' subfolder.

Running '4 Quantifying patterns of settlement.R' will ouput a csv file (1totalsettlementinreefarea_data.csv) into the working directory with counts/densitites for the number of larvae that settled on different substrates
within the reef area for each scenario. In this file the column 'sub' represents the attractiveness of different substrates where '1'=low, '2'=medium and '3'=high.

Run '5 Virtual sampling with quadrats' to simulate different strategies of sampling coral settlers with quadrats for two example scenarios:
1) Vertical substrate configuration with unidirectional flow
2) Vertical substrate configuration with oscillating flow

This will output a csv file to your working directory (2quadrat_sampling_data.csv) with settler counts in quadrats placed on different substrates for each scenario.
The column 'quadstrat' represents the sampling technique used with quadrats:
'1'=centre, '2'=left edge, '3'=right edge, '4'=random.

Run '6 Run simulations with settlement tiles' to rerun simulations with different settlement tile configurations (representing different strategies of sampling with tiles) for four example scenarios:
1) Vertical substrate configuration with unidirectional flow
2) Vertical substrate configuration with oscillating flow
3) Horizontal substrate configuration with unidirectional flow
4) Horizontal substrate configuration with oscillating flow
   
This will output a png (showing the distribution of coral settlers at the end of each simulation) and a csv file (with the coordinates where larvae settled within the reef area) for each scenario to the 'Outputs_tile_sampling' subfolder.

Run '7 Virtual Sampling Tiles Analysis' to get a dataframe with the number of larvae that settled on tiles for each sampling strategy for each scenario.
This will save a spreadsheet to your working directory (3tile_sampling_data.csv).
The column 'sub' represents the attractiveness of different substrates where
'4'=low, '5'=medium and '6'=high.

Run '8 Application to the reef.R' to upload reef 2D mosaic, to assign different substrate types and settlement probabilities prior to simulation.

Run '9 Application to the reef simulations.R' to simulate settlement on the reef 2D mosaic.

Run '10 Application to the reef sampling' to create a csv file with the counts/densities of coral settlers on each substrate type within the reef 2D mosaic. The column 'sub' represents the different substrates where
'1'=sand, '2'= live coral, '3'=rubble, '4' =dead staghorn coral , '5'=dead coral (other).

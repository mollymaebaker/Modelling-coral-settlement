
### Cumulative settlement probability plot

rm(list=ls())

library(ggplot2)
library(tidyr)

annastheme = theme_bw()+
  theme(legend.text=element_text(size=14),
        legend.title=element_text(size=14),
        legend.key.width=unit(1.2,"cm"),
        axis.title=element_text(size=14),
        axis.text = element_text(size = 12),
        title = element_text(size = 12),
        plot.title = element_text(size = 14, face = "bold"),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        strip.text = element_text(size = 14, colour = "black"),
        strip.background = element_rect("white"))

### Define the function
calculate_y <- function(x, p) {
  return(1 - ((1 - p)^x))
}

### Generate timesteps
timesteps <- 1:3000

### Convert timesteps to unit of choice
units <- timesteps * 0.1 /10 #turn timesteps into seconds then turn seconds into centimentres

### Calculate y values for different p values
p_values <- c(0.01, 0.03, 0.05, 0.07, 0.09)
y_values <- sapply(p_values, function(p) calculate_y(timesteps, p))

### Create a data frame for ggplot
data <- data.frame(units = rep(units, length(p_values)),
                   y_values = as.vector(y_values),
                   p = rep(p_values, each = length(timesteps)))

### Plot using ggplot
plot<-ggplot(data, aes(x = units, y = y_values, color = factor(p))) +
  geom_line(size=0.75) +
  labs(x = "Distance (cm)", y = "Cumulative probability larvae settled\nif travelling over substrata",
       title = "Plot of y = 1 - ((1 - p)^x)",
       color = "timestep \nsettlement \nprobability (p)") +
  ylim(0, 1) +
  xlim(0,5) + #chop x-axis to see what's going on better
  annastheme

plot+ scale_color_brewer(palette = "Blues")

ggsave(paste("Cumulative settlement prob_days", ".png"), width = 7, height = 5.5)

### Specify file name
getwd()
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/cumulative_plot.png"

### Specify size and resolution
width <- 7 # in inches
height <- 9 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = plot, width = width, height = height, dpi = dpi)



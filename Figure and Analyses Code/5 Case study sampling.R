###### Case study plots and analyses

rm(list=ls())


##### 1. Plot counts of coral settlers on different substrate types

data<-read.csv('5case_study_data.csv')

### Tidy data
str(data)

data$hydrodym<-as.factor(data$hydrodym)
data$quadname<-as.factor(data$quadname)
data$sub<-as.factor(data$sub)
data$counts<-as.numeric(data$counts)

library(ggplot2)

p1<-ggplot(data, aes(x=sub, y=counts, fill=sub)) +
  geom_boxplot()+
  theme_test()+
  theme(text = element_text(size = 20),axis.text = element_text(size = 18), legend.position = "none")+
  scale_fill_manual(values = c("1"= "#f5e5d3", "2"="#d4ac7c", "3"= "#7bcada", "4"= "#1f7aa0", "5"= "#552b00" ))+
  xlab("Substrate type") + ylab(bquote("Coral settler count"))+
  labs(fill="Substrate Attractiveness")+
  scale_x_discrete(labels=c('Sand', 'Live Coral', 'Rubble', 'DSC', 'DCPB'))+
  scale_y_continuous(limits = c(0, 250))

p1

### Specify file name
getwd()
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/case_study_counts.png"

### Specify size and resolution
width <- 7 # in inches
height <- 9 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p1, width = width, height = height, dpi = dpi)


##### 2. Plot density of coral settlers on different substrate types

p2<-ggplot(data, aes(x=sub, y=densities.Freq, fill=sub)) +
  geom_boxplot()+
  theme_test()+
  theme(text = element_text(size = 20),axis.text = element_text(size = 18), legend.position = "none")+
  scale_fill_manual(values = c("1"= "#f5e5d3", "2"="#d4ac7c", "3"= "#7bcada", "4"= "#1f7aa0", "5"= "#552b00" ))+
  xlab("Substrate type") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate Attractiveness")+
  scale_x_discrete(labels=c('Sand', 'Live Coral', 'Rubble', 'DSC', 'DCPB'))+
  scale_y_continuous(limits = c(0, 80))

p2

### Specify file name
getwd()
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/case_study_density.png"

### Specify size and resolution
width <- 7 # in inches
height <- 9 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p2, width = width, height = height, dpi = dpi)


##### 3. Combining settler counts and density plots

figure <- ggarrange(p1, p2, ncol = 1, nrow = 2)
figure

##### 4. Analyzing case study settler count data using GLM with quassipoisson distribution

boxplot(data$counts~data$sub)

poisson_model <- glm(counts ~ sub, data = data, family = quasipoisson(link = "log"))
summary(poisson_model)

### Calculate the dispersion statistic
observed_dispersion <- sum(residuals(poisson_model, type = "pearson")^2) / (nrow(data4) - length(poisson_model$coefficients))

### Compare observed dispersion to the expected value (1 for Poisson)
expected_dispersion <- 1
dispersion_ratio <- observed_dispersion / expected_dispersion
dispersion_ratio

### Chisquared to get p value
anova(poisson_model,test="Chisq")


##### 5. Analysing case study density data using one way test


boxplot(data$densities.Freq~data$sub)


### subset data to get rid of substrate types with a settlement probability of 0 (i.e., sand and live coral)

data_subset<- subset(data4, c(sub == "3","4","5" ))

str(data4)

library(dplyr)

subset<-data %>% 
  filter(sub %in% c("3", "4", "5"))

oneway.test(densities.Freq~sub, data=subset, var=FALSE)


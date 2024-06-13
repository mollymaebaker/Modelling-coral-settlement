################# 1. Plot quadrat sampling data


rm(list=ls())

data<-read.csv("3quadrat_sampling_data.csv")


### Tidy data
data<-quadrat_sampling_data

str(data)

data$hydrodym<-as.factor(data$hydrodym)
data$quadname<-as.factor(data$quadname)
data$sub<-as.factor(data$sub)
data$count<-as.numeric(data$count)
data$quadstrat<-as.factor(data$quadstrat)

library(ggplot2)

### Hydrodynamic levels
data$hydrodym <- factor(data$hydrodym, levels = c("flow", "oscillating"), 
                         labels = c("Unidirectional", "Oscillating"))

### Plot quadrat sampling results for two example scenarios (1): unidirectional flow and vertical 1 substrate configuration, (2): oscillating flow and vertical 1 substrate configuration
plot<-ggplot(data, aes(x=quadstrat, y=count, fill=sub)) +
  geom_boxplot(width=0.7)+
  theme_test()+
  theme(text = element_text(size = 20),axis.text = element_text(size = 18), legend.position = "none")+
  scale_fill_manual(values = c("1"= "#D4AC7B", "2"="#A0D3D7", "3"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Sampling technqiue") + ylab(bquote("Coral settler count"))+
  labs(fill="Substrate Attractiveness")+
  scale_x_discrete(labels=c('Centre', 'Left Edge', 'Right Edge', 'Random'))


p1<-plot+ facet_grid(hydrodym ~ ., scales ="free_y")+
  theme(strip.text = element_text(
    size = 18, face="bold"), strip.background = element_rect(fill="white"))

p1

library(ggh4x)

p1<-p1 +
  facetted_pos_scales(
    y = list(
      hydrodym == "Unidirectional" ~ scale_y_continuous(limits = c(0, 30)),
      hydrodym == "Oscillating" ~ scale_y_continuous(limits = c(0, 30))
    )
  )

p1

### Specify file name
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/quadrat.png"

width <- 10 # in inches
height <- 8 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p1, width = width, height = height, dpi = dpi)

### Summary statistics
data$combined<-paste(data$quadname, data$hydrodym, data$quadstrat, data$s)
aggregate(count~combined, data2, mean)
aggregate(count~combined, data2, median)
aggregate(count~combined, data2, max)
aggregate(count~combined, data2, min)

### 2. GLMs with quassipoisson distribution to account for overdispersion

data$combined<-paste(data$quadstrat, data$hydrodym)

comb_tirbs=unique(data$combined)

i=comb_tirbs[8]

subset_sample<-subset(data, combined ==i)

str(subset_sample)

boxplot(subset_sample$count~subset_sample$sub,
        main=paste0(subset_sample$combined[1]))

poisson_model <- glm(count ~ sub, data = subset_sample, family = quasipoisson(link = "log"))
summary(poisson_model)

### Calculate the dispersion statistic
observed_dispersion <- sum(residuals(poisson_model, type = "pearson")^2) / (nrow(subset_sample) - length(poisson_model$coefficients))

### Compare observed dispersion to the expected value (1 for Poisson)
expected_dispersion <- 1
dispersion_ratio <- observed_dispersion / expected_dispersion
dispersion_ratio

### Chisquared to get p value
anova(poisson_model,test="Chisq")


#### Summary plots of total counts
rm(list=ls())

data<-read.csv("3quadrat_summary.csv")

### Tidy data
head(data)

library(ggplot2)

### Hydrodynamic levels
data$hydrodym <- factor(data$hydrodym, levels = c( "flow", "oscillating"), 
                        labels = c( "Unidirectional", "Oscillating"))

### Substrate attractiveness levels
data$sub<-factor(data$sub, levels = c("1", "2", "3"), 
                 labels = c("Low", "Medium", "High"))

### Substrate configuration level(s)
data$quadname<-factor(data$quadname, levels = c("submat_V"), 
                      labels = c("Vertical 1 (V1)"))



p2<- ggplot(data, aes(x=sub, y=density_m, fill=sub))+
  geom_boxplot(width=0.7)+
  theme_test()+
  theme(text = element_text(size = 20),axis.text = element_text(size = 18), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"))+
  xlab("Substrate attractiveness") + ylab(bquote("Total density of coral settlers "  (m^-2)))+
  facet_wrap(~hydrodym, nrow = 2, strip.position = "right")+
  theme(strip.text = element_text(
    size = 18, face = "bold"),  strip.background = element_rect(fill="white"))

p2


### Specify file name
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/quadrat summary.png"

width <- 5 # in inches
height <- 8 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p2, width = width, height = height, dpi = dpi)


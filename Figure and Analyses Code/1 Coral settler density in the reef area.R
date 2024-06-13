##### 1. Plotting coral settler density within reef area in response to different scenarios

rm(list=ls())


### Input data file
data<-read.csv("1totalsettlementinreefarea_data.csv")


### Tidy data
data$hydrodym<-as.factor(data$hydrodym)

data$sub<-as.factor(data$sub)

data$quadstrat<-as.factor(data$quadstrat)

head(data)

library(ggplot2)

### Hydrodynamic levels
data$hydrodym <- factor(data$hydrodym, levels = c("active", "cyclo", "flow", "oscillating"), 
                        labels = c("No hydrodynamics", "Cyclonic Eddy", "Unidirectional", "Oscillating"))

### Substrate attractiveness levels
data$sub<-factor(data$sub, levels = c("1", "2", "3"), 
                 labels = c("Low", "Medium", "High"))


### Plot density of coral settlers on each substrate in response to each scenario
plot<-ggplot(data, aes(x=quadname, y=density_m, fill=sub)) +
  geom_boxplot(width=0.5)+
  theme_test()+
  theme(text = element_text(size = 20),axis.text = element_text(size = 18), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate Configuration") + ylab(bquote("Density of coral settlers "  (m^2)))+
  labs(fill="Substrate Attractiveness")+
  scale_x_discrete(labels=c('H1', 'H2', 'P1', 'P2', 'V1', 'V2', 'V3'))


p1<-plot+ facet_grid(hydrodym ~ ., scales ="free_y")+
  theme(strip.text = element_text(size=18, face="bold"), panel.spacing = unit(1, "cm"))

p1

### Summary statistics

data$combined<-paste(data$quadname, data$hydrodym, data$sub)

aggregate(density_m~combined, data, mean)
aggregate(density_m~combined, data, median)
aggregate(density_m~combined, data, max)
aggregate(density_m~combined, data, min)


##### 2. One way test to elucidate significant differences in the density of coral larvae that settled on different substrates in response to each scenario
data$combined<-paste(data$quadname, data$hydrodym)

comb_tirbs=unique(data$combined)

pss=NULL
names=NULL

for(i in comb_tirbs){
  
  i=comb_tirbs[1]
  
  PC_cyclo<-subset(data, combined ==i)
  
  boxplot(PC_cyclo$density_m~PC_cyclo$sub,
          main=paste0(PC_cyclo$combined[1]))
  
  oneway<-oneway.test(density_m~sub, data=PC_cyclo, var.equal = FALSE)
  oneway
  
  
  oneway1<-oneway.test(density_m~sub, data=PC_cyclo, var.equal = FALSE)$'p-value'[1]
  
  names=c(names,i)
  pss=c(pss,oneway1)
  
}

df=NULL
df$names=names
df$pss=pss
df=as.data.frame(df)

write.csv(df, "onewaytest_p_values.csv")


##### 3. Plotting coral settler density results for example scenarios selected out of the 28 scenarios simulated


### Subset data 
rm(list=ls())

data<-read.csv("1totalsettlementinreefarea_data.csv")


data$hydrodym<-as.factor(data$hydrodym)

data$sub<-as.factor(data$sub)

data$quadsname<-as.factor(data$quadname)

head(data)

library(ggplot2)
library(ggpubr)

data$hydrodym <- factor(data$hydrodym, levels = c("active", "cyclo", "flow", "oscillating"), 
                        labels = c("No hydrodynamics", "Cyclonic Eddy", "Unidirectional", "Oscillating"))

data$sub<-factor(data$sub, levels = c("1", "2", "3"), 
                 labels = c("Low", "Medium", "High"))

### Example plot one
active <- subset(data, hydrodym == "Unidirectional")
active<- subset(active, quadsname == "submat_V")

plot1<-ggplot(active, aes(x=sub, y=density_m, fill=sub)) +
  geom_boxplot()+
  theme_classic()+
  theme(panel.border=element_rect(fill=NA),text = element_text(size = 24),axis.text = element_text(size = 22), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate Attractiveness") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate Attractiveness")+
  scale_y_continuous(breaks = seq(20, 30, by = 2))
  

plot1

filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/plot1.png"
width <- 5 # in inches
height <- 5.1 # in inches
dpi <- 600 # dots per inch (resolution)
ggsave(filename, plot = plot1, width = width, height = height, dpi = dpi)

### Example plot two
cyclonic <- subset(data, hydrodym == "Cyclonic Eddy")
cyclonic<- subset(cyclonic, quadsname == "submat_V")

plot2<-ggplot(cyclonic, aes(x=sub, y=density_m, fill=sub)) +
  geom_boxplot()+
  theme_classic()+
  theme(panel.border=element_rect(fill=NA),text = element_text(size = 24),axis.text = element_text(size = 22), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate Attractiveness") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate Attractiveness")

plot2


filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/plot2.png"
width <- 5 # in inches
height <- 5.1 # in inches
dpi <- 600 # dots per inch (resolution)
ggsave(filename, plot = plot2, width = width, height = height, dpi = dpi)



### Example plot three
unidirectional <- subset(data, hydrodym == "Unidirectional")
unidirectional<- subset(unidirectional, quadsname == "submat_H")

plot3<-ggplot(unidirectional, aes(x=sub, y=density_m, fill=sub)) +
  geom_boxplot()+
  theme_classic()+
  theme(panel.border=element_rect(fill=NA),text = element_text(size = 24),axis.text = element_text(size = 22), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate Attractiveness") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate Attractiveness")

plot3


filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/plot3.png"
width <- 5 # in inches
height <- 5.1 # in inches
dpi <- 600 # dots per inch (resolution)
ggsave(filename, plot = plot3, width = width, height = height, dpi = dpi)


### Example plot four
oscillating <- subset(data, hydrodym == "Oscillating")
oscillating<- subset(oscillating, quadsname == "submat_P1")

plot4<-ggplot(oscillating, aes(x=sub, y=density_m, fill=sub)) +
  geom_boxplot()+
  theme_classic()+
  theme(panel.border=element_rect(fill=NA),text = element_text(size = 24),axis.text = element_text(size = 22), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate Attractiveness") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate Attractiveness")

plot4

filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/plot4.png"
width <- 5 # in inches
height <- 5.1 # in inches
dpi <- 600 # dots per inch (resolution)
ggsave(filename, plot = plot4, width = width, height = height, dpi = dpi)

### Example plot five
oscillating <- subset(data, hydrodym == "No hydrodynamics")
oscillating<- subset(oscillating, quadsname == "submat_Vdiff1")

plot5<-ggplot(oscillating, aes(x=sub, y=density_m, fill=sub)) +
  geom_boxplot()+
  theme_classic()+
  theme(panel.border=element_rect(fill=NA),text = element_text(size = 24),axis.text = element_text(size = 22), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate attractiveness") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate attractiveness")+
  scale_y_continuous(breaks = seq(6, 12, by = 2))

plot5

filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/plot5.png"
width <- 5 # in inches
height <- 5.1 # in inches
dpi <- 600 # dots per inch (resolution)
ggsave(filename, plot = plot5, width = width, height = height, dpi = dpi)


### Example plot six
oscillating <- subset(data, hydrodym == "Cyclonic Eddy")
oscillating<- subset(oscillating, quadsname == "submat_H")

plot6<-ggplot(oscillating, aes(x=sub, y=density_m, fill=sub)) +
  geom_boxplot()+
  theme_classic()+
  theme(panel.border=element_rect(fill=NA),text = element_text(size = 24),axis.text = element_text(size = 22), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Subsrate attractiveness") + ylab(bquote("Density of coral settlers " (m^-2)))+
  labs(fill="Substrate Attractiveness")+
  scale_y_continuous(breaks = seq(6, 12, by = 2))

plot6

filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/plot6.png"
width <- 5 # in inches
height <- 5.1 # in inches
dpi <- 600 # dots per inch (resolution)
ggsave(filename, plot = plot6, width = width, height = height, dpi = dpi)


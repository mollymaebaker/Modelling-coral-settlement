### Coral settler density - individual effect plots and interactive plots


### Clear library and import data
rm(list=ls())

data<-read.csv("2totalsettlementinreefarea_data.csv")


library(ggplot2)

### Tidy data

### Hydrodynamic levels
data$hydrodym <- factor(data$hydrodym, levels = c("active", "cyclo", "flow", "oscillating"), 
                        labels = c("No hydrodynamics", "Cyclonic Eddy", "Unidirectional", "Oscillating"))

### Substrate attractiveness levels
data$sub<-factor(data$sub, levels = c("1", "2", "3"), 
                 labels = c("Low", "Medium", "High"))


### Substrate configuration levels
data$quadname<-factor(data$quadname, levels = c("submat_H", "submat_HR", "submat_P1", "submat_P2", "submat_V", "submat_Vdiff1", "submat_Vdiff2"), 
                      labels = c("Horizontal-1 (H1)", "Horizontal-2 (H2)", "Patchy-1 (P1)", "Patchy-2 (P2)", "Vertical-1 (V1)", "Vertical-2 (V2)", "Vertical-3 (V3)"))


##### 1. Plot combined substrate attractiveness effect across all 28 scenarios

p1<- ggplot(data, aes(x=sub, y=density_m, fill=sub))+
  geom_boxplot()+
  stat_summary(fun.y = mean, geom="point", shape=15, size=3.5, color="black", fill="black")+
  theme_classic()+
  theme(text = element_text(size = 18),axis.text = element_text(size = 16), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"))+
  xlab("Substrate Attractiveness") + ylab(bquote("Density of coral settlers  "  (m^-2)))

p1

### Specify file name

getwd()
filename <- "C:/Users/22797943/PhD/Molly Modelling/substrate attractiveness.png"

### Specify size and resolution
width <- 8 # in inches
height <- 10 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p1, width = width, height = height, dpi = dpi)

### Summary statistics 
aggregate(density_m~sub, data, median)
aggregate(density_m~sub, data, mean)
aggregate(density_m~sub, data, min)
aggregate(density_m~sub, data, max)


### One way test for substrate attractiveness
oneway<-oneway.test(density_m~sub, data=data, var.equal = FALSE)
oneway


##### 2. Plot substrate attractiveness and hydrodynamic effect 

p2<- ggplot(data, aes(x=sub, y=density_m, fill=sub))+
  geom_boxplot()+
  stat_summary(fun.y = mean, geom="point", shape=15, size=1.5, color="black", fill="black")+
  theme_test()+
  theme(text = element_text(size = 18),axis.text = element_text(size = 16), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"))+
  xlab("Substrate Attractiveness") + ylab(bquote("Density of coral settlers "  (m^-2)))

p2<-p2+ facet_wrap(~hydrodym)+
  theme(strip.text = element_text(
    size = 16, face="bold"), strip.background = element_rect(fill="white"))

p2

### Specify file name
filename <- "C:/Users/22797943/PhD/Molly Modelling/hydrodynamics.png"
width <- 8 # in inches
height <- 10 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p2, width = width, height = height, dpi = dpi)


### Summary statistics for hydrodynamics
data$combined<-paste(data$hydrodym, data$sub)
aggregate(density_m~combined, data, median)
aggregate(density_m~combined, data, mean)
aggregate(density_m~combined, data, max)
aggregate(density_m~combined, data, min)

data$combined<-paste(data$hydrodym)
aggregate(density_m~combined, data, mean)

### One way test for hydrodynamics
data$combined<-paste(data$hydrodym)

comb_tirbs=unique(data$combined)

pss=NULL
names=NULL

### Repeat for each level of comb_tirbs i.e., each hydrodynamic condition
i=comb_tirbs[1]

PC_cyclo<-subset(data, combined ==i)

boxplot(PC_cyclo$density_m~PC_cyclo$sub,
        main=paste0(PC_cyclo$combined[1]))

oneway<-oneway.test(density_m~sub, data=PC_cyclo, var.equal = FALSE)
oneway

##### 3. Plot substrate attractiveness and substrate configuration

p3<- ggplot(data, aes(x=sub, y=density_m, fill=sub))+
  geom_boxplot()+
  stat_summary(fun.y = mean, geom="point", shape=15, size=1.5, color="black", fill="black")+
  theme_test()+
  theme(text = element_text(size = 18),axis.text = element_text(size = 16), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"))+
  xlab("Substrate Attractiveness") + ylab(bquote("Density of coral settlers "  (m^-2)))+
  facet_wrap(~quadname, ncol = 2)+
  theme(strip.text = element_text(
    size = 16, face="bold"), strip.background = element_rect(fill="white"))

p3

### Specify file name
filename <- "C:/Users/22797943/PhD/Molly Modelling/configuration.png"
width <- 8 # in inches
height <- 10 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p3, width = width, height = height, dpi = dpi)

### Summary statistics for substrate configuration
data$combined2<-paste(data$quadname, data$sub)
aggregate(density_m~combined2, data, mean)
aggregate(density_m~combined2, data, median)
aggregate(density_m~combined2, data, max)
aggregate(density_m~combined2, data, min)


### One way test for substrate configurations

data$combined2<-paste(data$quadname)

comb_tirbs=unique(data$combined2)

### Repeat for each level of comb_tirbs i.e., each substrate configuration
i=comb_tirbs[7]

PC_cyclo<-subset(data, combined2 ==i)

boxplot(PC_cyclo$density_m~PC_cyclo$sub,
        main=paste0(PC_cyclo$combined2[1]))

oneway<-oneway.test(density_m~sub, data=PC_cyclo, var.equal = FALSE)
oneway


### 4. Plot interactions among all three factors (substrate attractiveness, hydrodynamics and substrate configuration)

library(ggplot2)
p4<- ggplot(data, aes(x=sub, y=density_m, fill=sub))+
  geom_boxplot()+
  theme_test()+
  theme(text = element_text(size = 18),axis.text = element_text(size = 16), legend.position = "none")+
  scale_fill_manual(values = c("Low"= "#D4AC7B", "Medium"="#A0D3D7", "High"= "#1F7AA6"))+
  xlab("Substrate attractiveness") + ylab(bquote("Density of coral settlers "  (m^-2)))

p4<-p4 + facet_grid(vars(hydrodym),vars(quadname), scales="free")+
  theme(strip.text = element_text(
    size = 16, face="bold"), strip.background = element_rect(fill="white"))

p4

### Specify file name
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/interaction.png"
width <- 18 # in inches
height <- 10 # in inches
dpi <- 600 # dots per inch (resolution)

# Save the plot in higher resolution
ggsave(filename, plot = p4, width = width, height = height, dpi = dpi)

#Summary statistics for interactions
data$combined3<-paste(data$quadname, data$hydrodym, data$sub)
aggregate(density_m~combined3, data, mean)
aggregate(density_m~combined3, data, median)
aggregate(density_m~combined3, data, max)
aggregate(density_m~combined3, data, min)

###### One way test to elucidate significant differences in the density of coral larvae that settled on different substrates in response to each scenario
data$combined<-paste(data$quadname, data$hydrodym)

comb_tirbs=unique(data$combined)

pss=NULL
names=NULL

for(i in comb_tirbs){
  
  i=comb_tirbs[18]
  
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

write.csv(df, "onewaytest_p_values1.csv")




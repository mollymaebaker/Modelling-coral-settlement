################# 1 Plot recruitment tile sampling data for average count

rm(list=ls())

data<-read.csv('4settlement_tile_data.csv')

### Tidy data
str(data)

library(dplyr)

data = data %>% dplyr:: mutate(Configuration = ifelse(quadname %in% c("submat_VwTC", "submat_VwTL", "submat_VwTR","submat_VwTRan"), "vertical", "horizontal" ))

data$facet1<-paste(data$hydrodym, data$Configuration)

data$facet1<-as.factor(data$facet1)
levels(data$facet1)
 
#data3 <- data3[!(data3$quadname %in% c("submat_HwTC", "submat_HwTL", "submat_HwTR", "submat_HwTRan") & data3$hydrodym == 'oscillating'), ]


data$hydrodym<-as.factor(data$hydrodym)
data$quadname<-as.factor(data$quadname)
data$sub<-as.factor(data$sub)
data$counts<-as.numeric(data$counts)
data$average<-as.numeric(data$average)
data$facet1<-as.factor(data$facet1)

library(ggplot2)

### Hydroynamic levels
data$hydrodym <- factor(data$hydrodym, levels = c("flow", "oscillating"), 
                         labels = c("Unidirectional", "Oscillating"))

### Tile sampling technique levels
data$quadname<-factor(data$quadname, levels = c("submat_VwTC", "submat_VwTL", "submat_VwTR","submat_VwTRan", "submat_HwTC", "submat_HwTL", "submat_HwTR", "submat_HwTRan" ),
                       labels = c("Centre", "Left Edge", "Right Edge", "Random","Centre", "Left Edge", "Right Edge", "Random"))

### Scenario levels
levels(data$facet1)
data$facet1 <- factor(data$facet1, levels = c("oscillating vertical", "oscillating horizontal", "flow vertical", "flow horizontal"),
                         labels = c(" V1 Oscillating", "H2 Oscillating", " V1 Unidirectional", "H2 Unidirectional"))

plot<-ggplot(data, aes(x=quadname, y=average, fill=sub)) +
  geom_boxplot()+
  theme_test()+
  theme(text = element_text(size = 18),axis.text = element_text(size = 16), legend.position = "none")+
  scale_fill_manual(values = c("4"= "#D4AC7B", "5"="#A0D3D7", "6"= "#1F7AA6"), labels=c('Low', 'Medium', 'High'))+
  xlab("Sampling design") + ylab(bquote("Average coral settler count"))+
  labs(fill="Substrate Attractiveness")


p1<-plot+ facet_grid(facet1 ~ ., scales ="free_y")+
  theme(strip.text = element_text(size=16, face = "bold"), strip.background = element_rect(fill="white"))

p1

library(ggh4x)

p1<-p1 +
  facetted_pos_scales(
    y = list(
      facet1 == " V1 Unidirectional" ~ scale_y_continuous(limits = c(0, 20)),
      facet1 == " V1 Oscillating" ~ scale_y_continuous(limits = c(0, 20)),
      facet1 == "H2 Unidirectional" ~ scale_y_continuous(limits = c(0, 20)),
      facet1 == "H2 Oscillating" ~ scale_y_continuous(limits = c(0, 20))
    )
  )

p1

### Specify file name
getwd()
filename <- "C:/Users/22797943/PhD/CHAPTER 1/Figures/Final/tiles.png"

### Specify size and resolution
width <- 7 # in inches
height <- 9 # in inches
dpi <- 600 # dots per inch (resolution)

### Save the plot in higher resolution
ggsave(filename, plot = p1, width = width, height = height, dpi = dpi)


##### 2. GLMs with quassipoisson distribution to account for overdispersion
rm(list=ls())

data<-read.csv('4settlement_tile_data.csv')

### Tidy data
data$hydrodym<-as.factor(data$hydrodym)
data$quadname<-as.factor(data$quadname)
data$sub<-as.factor(data$sub)
data$counts<-as.numeric(data$counts)
data$average<-as.numeric(data$average)

### Remove extreme outliers
data <- data[-220, ]


data$combined<-paste(data$quadname, data$hydrodym)

comb_tirbs=unique(data$combined)


### Repeat for each level of comb_tirbs i.e., each sampling technique for each scenario
i=comb_tirbs[16]

subset_sample<-subset(data, combined ==i)

str(subset_sample)

boxplot(subset_sample$count~subset_sample$sub,
        main=paste0(subset_sample$combined[1]))

poisson_model <- glm(counts ~ sub, data = subset_sample, family = quasipoisson(link = "log"))
summary(poisson_model)

### Calculate the dispersion statistic
observed_dispersion <- sum(residuals(poisson_model, type = "pearson")^2) / (nrow(subset_sample) - length(poisson_model$coefficients))

### Compare observed dispersion to the expected value (1 for Poisson)
expected_dispersion <- 1
dispersion_ratio <- observed_dispersion / expected_dispersion
dispersion_ratio

### Chi squared test to get p value
anova(poisson_model,test="Chisq")


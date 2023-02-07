remove(list = ls())

#load libraries
library(ggplot2)
library(plotrix) #to calculate standard errors

#read in data
Fis <- read.csv("Fis.csv")
  colnames(Fis) <- c("locus", "Japan", "Indonesia", "Philippines")
Ho <- read.csv("Ho.csv")
  colnames(Ho) <- c("locus", "Japan", "Indonesia", "Philippines")
He <- read.csv("He.csv")
  colnames(He) <- c("locus", "Japan", "Indonesia", "Philippines")

###########################################################################################################

#pull Japan means & standard errors
nona_JFis <- Fis[!is.na(Fis$Japan), 2]
J_Fis_mean <- mean(nona_JFis)
J_Fis_ste <- std.error(nona_JFis)
J_Fis <- cbind(J_Fis_mean, J_Fis_ste)

##Means: Fis
# Japan -0.07807
# Indonesia -0.01528
# Philippines 0.01537

##Standard Errors: Fis
# Japan 0.00639
# Indonesia 0.006734
# Philippines 0.005872

J_Ho_mean <- mean(Ho$Japan)
J_Ho_ste <- std.error(Ho$Japan)
J_Ho <- cbind(J_Ho_mean, J_Ho_ste)

## Means: Ho
# Japan 0.2378
# Indonesia 0.2460
# Philippines 0.24463

## Standard Error: Ho
# Japan 0.003945
# Indonesia 0.003746
# Philippines 0.005871


J_He_mean <- mean(He$Japan)
J_He_ste <- std.error(He$Japan)
J_He <- cbind(J_He_mean, J_He_ste)

## Means: He
# Japan 0.2116
# Indonesia 0.2460
# Philippines 0.2436


## Standard Error: He
# Japan 0.002839
# Indonesia 0.002930
# Philippines 0.002542

J_div_sum <- cbind(J_Fis, J_Ho, J_He)

#copy the code above and repeat to make P_div_sum and I_div_sum for the Philippines and Indonesia

#write out summary table
tot_div_sum <- data.frame(rbind(J_div_sum, P_div_sum, I_div_sum))
tot_div_sum$Pop <- c("Japan", "Philippines", "Indonesia")
  colnames(tot_div_sum) <- c("Fis_mean", "Fis_sterror", "Ho_mean", "Ho_sterror", "He_mean", "He_sterror", "Pop")
  rownames(tot_div_sum) <- c("Japan", "Philippines", "Indonesia")

write.csv(tot_div_sum, "diversity_mean_std.csv")

###############################################################################################################

#create scatterplot
tot_div_sum <- read.csv("diversity_mean_std.csv")

tot_div_sum$Pop2 <- factor(tot_div_sum$Pop, levels = c("Japan", "Philippines", "Indonesia"))

#Fis scatterplot
Fis_plot <- ggplot(data = tot_div_sum, aes(x = Pop2, y = Fis_mean)) + geom_point() + 
  geom_errorbar(aes(ymin = Fis_mean - Fis_sterror, ymax = Fis_mean + Fis_sterror))
Fis_plot

#tips on how to change scatterplot appearance: http://www.sthda.com/english/wiki/ggplot2-scatter-plots-quick-start-guide-r-software-and-data-visualization
#tips on how to change errorbar appearance: http://www.sthda.com/english/wiki/ggplot2-error-bars-quick-start-guide-r-software-and-data-visualization
#tips on how to change plot background appearance: http://www.sthda.com/english/wiki/ggplot2-themes-and-background-colors-the-3-elements
#tips on how to change axis/axis title appearance: http://www.sthda.com/english/wiki/ggplot2-title-main-axis-and-legend-titles & http://www.sthda.com/english/wiki/ggplot2-axis-ticks-a-guide-to-customize-tick-marks-and-labels 
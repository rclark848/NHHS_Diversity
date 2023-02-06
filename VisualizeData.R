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

J_Ho_mean <- mean(Ho$Japan)
J_Ho_ste <- std.error(Ho$Japan)
J_Ho <- cbind(J_Ho_mean, J_Ho_ste)

J_He_mean <- mean(He$Japan)
J_He_ste <- std.error(He$Japan)
J_He <- cbind(J_He_mean, J_He_ste)

J_div_sum <- cbind(J_Fis, J_Ho, J_He)

#pull Philippines means & standard errors
nona_PFis <- Fis[!is.na(Fis$Philippines), 4]
P_Fis_mean <- mean(nona_PFis)
P_Fis_ste <- std.error(nona_PFis)
P_Fis <- cbind(P_Fis_mean, P_Fis_ste)

P_Ho_mean <- mean(Ho$Philippines)
P_Ho_ste <- std.error(Ho$Philippines)
P_Ho <- cbind(P_Ho_mean, P_Ho_ste)

P_He_mean <- mean(He$Philippines)
P_He_ste <- std.error(He$Philippines)
P_He <- cbind(P_He_mean, P_He_ste)

P_div_sum <- cbind(P_Fis, P_Ho, P_He)

#pull Indonesia means & standard errors
nona_IFis <- Fis[!is.na(Fis$Indonesia), 3]
I_Fis_mean <- mean(nona_IFis)
I_Fis_ste <- std.error(nona_IFis)
I_Fis <- cbind(I_Fis_mean, I_Fis_ste)

I_Ho_mean <- mean(Ho$Indonesia)
I_Ho_ste <- std.error(Ho$Indonesia)
I_Ho <- cbind(I_Ho_mean, I_Ho_ste)

I_He_mean <- mean(He$Indonesia)
I_He_ste <- std.error(He$Indonesia)
I_He <- cbind(I_He_mean, I_He_ste)

I_div_sum <- cbind(I_Fis, I_Ho, I_He)

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
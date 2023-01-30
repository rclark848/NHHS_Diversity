######## Set-up ########

remove(list = ls())

#load libraries#
#you will need to install these with install.packages() first
library(adegenet)
library(pegas)
library(hierfstat)
library(tidyverse)

#read in data
SNPs_mac2 <- readRDS("Aclarkii_genind.RDS")
#sum_stats_mac2 <- readRDS("sum_stats_mac2.RDS")

################################################################################################################################################

######## Compute diversity statistics w/only SNPs w/mac >/= 2 ########

#Pop 1 = Japan, Pop 2 = Indonesia, Pop 3 = Philippines
sum_stats_mac2 <- basic.stats(SNPs_mac2) #hierfstat function --> gives Ho, Hs, Fis on locus basis/pop as well as some pop-wide summary stats (Hs from Nei & Chesser 1983)

################################################################################################################################################

######## calculate Ho (observed heterozygosity) ########

## calculate Ho per locus ##
I_Hs <- sum_stats_mac2$Hs
I_Hs <- Hs[,2]
 #pull out Ho for J pop --> combined into one line of code

## calculate mean Ho in each pop ##
mean_Ho_I <- mean(I_Ho)
mean_Ho_J #0.238

##Japan 0.2378
##Indonesia 0.24604
##Philippines 0.24463

## Indonesia has the highest heterozygosity in the population followed by the Philippines and then Japan. 
## Their diversities are similar, but it still supports my hypothesis that the core populations are more closely correlated. 
## Hence, there is also less diversity present in the Japan location.

################################################################################################################################################

#calculate mean Hs (expected heterozygosity?) and Fis (inbreeding coefficient) for all three populations
#hint: repeat the previous lines of code as needed for each population and metric, changing as necessary

##Hs

#Japan 0.21164
#Indonesia 0.24033
#Philippines 0.24356

## Similar ordeal with observed heterozygosity. Here, however, Japan had a much lower expected diversity.
## As such, there is less of a gap than i may have hypothesized. Nonetheless, there is still a gap for the populations. 

##Fis - might need to troubleshoot this.. i dont think my computations are accurate 


##Japan -0.1126
##Indonesia -0.0153
##Philippines 0.0154

################################################################################################################################################

#try to write out diversity metrics for three populations as a csv (use write.csv()) -- either per locus or mean statistics work

write.csv(Ho, "Ho.csv")
#can you combine the Ho, Hs, and Fis dataframes into one to write out?
#hint: google how to merge multiple dataframes

#test
##test
##
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
Ho <- sum_stats_mac2$Ho
J_Ho <- Ho[,1]
J_Ho_df <- data.frame(J_Ho)
J_Ho_df <- data.frame(sum_stats_mac2$Ho[,1]) #pull out Ho for J pop --> combined into one line of code

## calculate mean Ho in each pop ##
mean_Ho_J <- mean(J_Ho)
mean_Ho_J #0.238

################################################################################################################################################

#calculate mean Hs and Fis for all three populations
#hint: repeat the previous lines of code as needed for each population and metric, changing as necessary

################################################################################################################################################

#try to write out diversity metrics for three populations as a csv (use write.csv()) -- either per locus or mean statistics work

write.csv(Ho, "Ho.csv")
#can you combine the Ho, Hs, and Fis dataframes into one to write out?
#hint: google how to merge multiple dataframes
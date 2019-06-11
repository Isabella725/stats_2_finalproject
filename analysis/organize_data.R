#' ---
#' title: "organize_data.R"
#' author: "Isabella Clark"
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory. 

library(haven)
anes <- read_dta("analysis/input/anes_timeseries_2016_dta/anes_timeseries_2016.dta")
View(anes)

#rename variables 
anes <- subset(anes, V160501==1)

anes$climatebelief <- factor(ifelse(anes$V161221<0, NA, 
                                            anes$V161221),
                                             levels=c(2,1),
                                             labels=c("No","Yes"))
table(anes$V161221, anes$climatebelief, exclude=NULL)

anes$anthro <- factor(ifelse(anes$V161222<0, NA, 
                                              anes$V161222),
                                             levels=c(1,2,3),
                                             labels=c("human","natural","equal"))
table(anes$anthro, exclude=NULL)
anes$children <- factor(ifelse(anes$V165506<0, NA,
                               anes$V165506),
                                levels=c(2,1),
                                labels=c("No","Yes"))
table(anes$V165506, anes$children, exclude=NULL)
anes$gender <- factor(ifelse(anes$V161342<0, NA,
                             anes$V161342),
                              levels=c(3,2,1),
                              labels=c("Other","Female","Male"))
table(anes$gender, exclude=NULL)


#source in any useful functions
source("useful_functions.R")


#Convert numeric codes for categorical variables into proper factor variables
#Replace numeric codes for missing values with NA values
#Collapse categories in categorical variables into smaller sets.


#Create a compound variable from a combination of other variables. 
#Remove all unneeded variables from the final analytical dataset
#In order to preserve formatting, it is easiest to save your final analytical dataset as an RData file with the save command:

anes <- subset(anes,
               select=c("climatebelief", "anthro", "children", "gender"))
  save(anes, file="analysis/output/analytical_data.RData")
  
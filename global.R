# ==============================================================================
#   
#  Script name......global.R
#  Project..........shinydb_se_education
#  Script purpose...Supply the global environment for "shinydb_se_education" 
#                   dashboard
#
#  Author...........Nathalie Nilsson
#
#  Date created.....2021-01-04
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Packages ---------------------------------------------------------------------
library(tidyverse)
library(viridis)
library(extrafont)
loadfonts(quiet = TRUE)
library(plotly)

# Functions --------------------------------------------------------------------
source('./functions.R')
source('./icons.R')


# Data -------------------------------------------------------------------------
# Source: https://www.scb.se. 
ub <- read.csv2("./data/scb_befolkningEfterUtbildningsNivå_län.csv", 
                sep = ";", 
                skip = 2)

# Convert from wide to long format
ub.l <- ub %>%
  gather(key = "year", value = "number", X1985:X2019) # long format

ub.l$year <- as.numeric(gsub("X", "", ub.l$year)) # remove 'X' from 'year' column and convert to numeric

# Create dictionary for translating educational levels
edu_dict <- data.frame(se_level = unique(ub.l$utbildningsnivå), 
                       en_level = c("Pre-high school, <9 years", 
                                    "Pre-high school, 9 (10) years", 
                                    "High school, 2 years", 
                                    "High school, 3 years", 
                                    "College, <3 years", 
                                    "College/Bachelor/Master, >3 years", 
                                    "PhD", 
                                    "Missing data"))

# Translation
ub.l$age  <- gsub("år", "years", ub.l$ålder)
ub.l$gender <- factor(ub.l$kön, 
                      levels = c("män", "kvinnor"), 
                      labels = c("Men", "Women"))
ub.l$edulevel <- sapply(ub.l$utbildningsnivå, function(x) 
  dict_replace(x, value = edu_dict$se_level, key = edu_dict$en_level))

# Factorize the education variable
ub.l$edu <- factor(ub.l$edulevel, levels = unique(ub.l$edulevel))

# Create English table
ub.en <- select(ub.l, 
                region, age, edu, gender, year, number)

# Calculate the total population assessed each year
pop <- ub.l %>%
  group_by(year, gender) %>%
  summarise(population = sum(number))

# Visualization parameters -----------------------------------------------------
v_d_palette <- viridis(20, option = "D")

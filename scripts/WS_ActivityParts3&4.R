{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  ############
  # Activity #
  ############
  
  # This time, we’ll be using the larval white sucker data. Subset the data set 
  # from April to September. Plot month vs zooplankton and larval white sucker 
  # abundance, and create a separate plot for each year by faceting. Add a second 
  # axis for the white sucker abundance (you will need to calculate a new scaling 
  # coefficient here, using the same method that was used to calculate the scaling 
  # coefficient for the larval white bass data). Change the color of the 
  # lines and the theme of the plot as you see fit, making sure to reflect this in 
  # the legend.
  
}

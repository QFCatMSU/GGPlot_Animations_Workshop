{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  ############
  # Activity #
  ############
  
  # This time, we’ll be using the larval white sucker data. 
  #
  #   (1) Subset the data set from April to September.
  #
  #   (2) Plot month vs zooplankton and larval white sucker abundance.
  #
  #   (3) Create a separate plot for each year by faceting.
  #
  #   (4) Add a second axis for the white sucker abundance; you will need 
  #       to calculate a new scaling coefficient here, using the same method 
  #       that was used to calculate the scaling coefficient for the larval 
  #       white bass data. 
  #
  #   (5) Change the color of the lines and the theme of the plot as you see 
  #       fit, making sure to reflect this in the legend. 
  
}

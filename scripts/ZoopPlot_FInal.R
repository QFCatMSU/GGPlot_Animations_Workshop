#12/6/20
# Plot data

{
  
  rm(list=ls());
  options(show.error.locations=TRUE);
  
  bass <- read.csv("data/whitebass_final.csv");
  sucker <- read.csv("data/whitesucker_final.csv");
  zooplank <- read.csv("data/zooplankton_final.csv")l
  
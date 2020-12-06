#12/6/20
# Plot data

{
  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library("plyr")
  
  bass <- read.csv("data/whitebass_final.csv");
  sucker <- read.csv("data/whitesucker_final.csv");
  zooplank <- read.csv("data/zooplankton_final.csv");
  
  sucker$year <- mapvalues(sucker$year, from = c(2010,2014,2015,2016), to = c(2008,2009,2010,2011))
  bass$year <- mapvalues(bass$year, from = c(2011,2014,2015,2016), to = c(2008,2009,2010,2011))
  zooplank$year <- zooplank$year4
  
  ggplot(data=zooplank, aes(x=month,y=abundance/1000))+
    geom_smooth(color="orange")+
    geom_smooth(data=sucker, aes(x=month,y=abundance), color="purple")+
    facet_wrap(~year)
  
  
}
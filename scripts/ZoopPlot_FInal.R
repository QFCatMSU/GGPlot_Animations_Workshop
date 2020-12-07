#12/6/20
# Plot data

{
  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library("plyr")
  
  bass <- read.csv("data/whitebass_final.csv");
  sucker <- read.csv("data/whitesucker_final.csv");
  zooplank <- read.csv("data/zooplankton_final.csv");
  
  zooplank$year <- zooplank$year4
  zooplank$year <- mapvalues(zooplank$year, from = c(2005,2007,2008,2009), to = c(2008,2009,2010,2011))
  sucker$year <- mapvalues(sucker$year, from = c(2010,2014,2015,2016), to = c(2008,2009,2010,2011))
  bass$year <- mapvalues(bass$year, from = c(2011,2014,2015,2016), to = c(2008,2009,2010,2011))
  
  coeff <- max(sucker$abundance)/max(zooplank$abundance)
  ggplot()+
    geom_line(data=zooplank, aes(x=month,y=abundance,color="Zooplankton"),size=1.25)+
    geom_line(data=sucker, aes(x=month,y=abundance/coeff,color="White Sucker"), size= 1.25)+
    scale_y_continuous(
      # Features of the first axis
      name = "Zooplankton abundance",
      # Add a second axis and specify its features
      sec.axis = sec_axis(~.*coeff, name="White Sucker abundance"))+
    facet_wrap(~year)+
    labs(title="Zooplankton vs. White sucker abundance",color="Species")
    #scale_color_manual(values=list("White Sucker"="blue","Zooplankton"="orange"))
  
  coeff <- max(bass$abundance)/max(zooplank$abundance)
  ggplot()+
    geom_line(data=zooplank, aes(x=month,y=abundance,color="Zooplankton"),size=1.25)+
    geom_line(data=bass, aes(x=month,y=abundance/coeff,color="White Bass"), size= 1.25)+
    scale_y_continuous(
      # Features of the first axis
      name = "Zooplankton abundance",
      # Add a second axis and specify its features
      sec.axis = sec_axis(~.*coeff, name="White Bass abundance"))+
    facet_wrap(~year)+
    labs(title="Zooplankton vs. White Bass abundance",color="Species")
  #scale_color_manual(values=list("White Sucker"="blue","Zooplankton"="orange"))
  
}

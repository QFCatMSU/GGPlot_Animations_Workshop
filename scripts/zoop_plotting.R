#plotting  zooplankton abundance and larval fish abundance
{
  rm(list=ls());
  options(show.error.locations=TRUE);
  
  library(tidyverse)
  library(lubridate)
  
  data <- read_csv("data/cascade_zooplankton_v0.5_upload.csv");
  
  pauldat <- data %>% filter(lakename == "Paul Lake");
  
  ggplot(data=pauldat %>% filter(group_code == "CLAD"))+
    geom_point(mapping = aes(x= daynum,y=abundance,colour = as.character(year4)));
  
  pauldat1 <- pauldat %>% group_by(year4,daynum,group_code) %>% 
    summarise(
      abundance = sum(abundance)
    );
  unique(pauldat1$group_code);
  
  ggplot(data=pauldat1 %>% filter(group_code == "CLAD"))+
    geom_point(mapping = aes(x= daynum,y=abundance,colour = as.character(year4)));
  
  ggplot(data=pauldat1 %>% filter(group_code == "CLAD" & year4 >=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance,colour = as.character(year4)));
  
  ggplot(data=pauldat1 %>% filter(group_code == "CLAD" & year4 >=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  ggplot(data=pauldat1 %>% filter(group_code == "CLAD" & year4 <=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  ggplot(data=pauldat1 %>% filter(group_code == "OCOP" & year4 >=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  ggplot(data=pauldat1 %>% filter(group_code == "OCOP" & year4 <=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  peterdat <- data %>% filter(lakename == "Peter Lake")
  peterdat$month <- month(peterdat$sampledate)
  peterdat1 <- peterdat %>% group_by(year4,month,group_code) %>% 
    summarise(
      abundance = sum(abundance)
    );
  #make dataframe from years 2008 to 2011;
  ggplot(data=peterdat1 %>% filter(group_code == "CLAD" & year4 >=2000))+
    geom_point(mapping = aes(x= month,y=abundance))+
    facet_wrap(vars(year4));
  
  zooplank_final <- peterdat1 %>% filter(group_code=="CLAD",year4>2007, year4<2012)
  
  write.csv(zooplank_final, "data/zooplankton_final.csv")
  
  ggplot(data=peterdat1 %>% filter(group_code == "CLAD" & year4 ==2013))+
    geom_point(mapping = aes(x= daynum,y=abundance));
  
  ggplot(data=peterdat1 %>% filter(group_code == "CLAD" & year4 <=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  ggplot(data=peterdat1 %>% filter(group_code == "CCOP" & year4 >=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  ggplot(data=peterdat1 %>% filter(group_code == "CCOP" & year4 <=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  
  larvalfish <-  read.csv("data/LarvalData.csv");
  
  unique(larvalfish$WaterBody);
  larvFishErie <- larvalfish %>% filter(WaterBody == "Lake Erie");
  ggplot(data = larvFishErie)+geom_point(mapping = aes(x=SetDate,y=LarvalSum));
  
  
  
  
  larvFishErie$SetDate <- dmy(larvFishErie$SetDate);
  ggplot(data = larvFishErie)+
    geom_point(mapping = aes(x=SetDate,y=LarvalSum));
  larvFishErie$year <- year(larvFishErie$SetDate);
  larvFishErie$month <- month(larvFishErie$SetDate);
  larvFishErie$day <- day(larvFishErie$SetDate);
  
  larvFishErie1 <- larvFishErie %>% group_by(year,month,day) %>% 
    summarise(
      abundance = sum(LarvalSum)
    );
  
  ggplot(data = larvFishErie1 %>% filter(year==2015))+
    geom_point(mapping = aes(x=day,y=abundance));
  
  ggplot(data = larvFishErie1)+
    geom_point(mapping = aes(x=day,y=abundance))+
    facet_wrap(vars(year));
  
  ################detroit river
  larvFishDR <- larvalfish %>% filter(WaterBody == "Detroit River");
  ggplot(data = larvFishDR)+geom_point(mapping = aes(x=SetDate,y=LarvalSum));
  
  library(lubridate);
  
  
  larvFishDR$SetDate <- dmy(larvFishDR$SetDate);
  ggplot(data = larvFishDR)+geom_point(mapping = aes(x=SetDate,y=LarvalSum));
  larvFishDR$year <- year(larvFishDR$SetDate);
  larvFishDR$month <- month(larvFishDR$SetDate);
  larvFishDR$day <- day(larvFishDR$SetDate);
  #larvFishDR <- larvFishDR %>% select(SetDate,month,day,year,Cyprinidae)
  larvFishDR2 <- larvFishDR %>% select(SetDate,month,day,year,Morone)
  
  ggplot(data = larvFishDR %>% filter(year==2015))+
    geom_point(mapping = aes(x=SetDate,y=Cyprinidae));
  
  larvFishDR1 <- larvFishDR %>% group_by(year,month) %>% 
    summarise(
      abundance = sum(Cyprinidae)
    );
  larvFishDR2 <- larvFishDR2 %>% group_by(year,month) %>% 
    summarise(
      abundance = sum(Morone)
    );
  ggplot(data = larvFishDR1 %>% filter(year==2015))+
    geom_point(mapping = aes(x=month,y=abundance));
  
  ggplot(data = larvFishDR1)+
    geom_point(mapping = aes(x=month,y=abundance))+
    facet_wrap(vars(year));
  ggplot(data = larvFishDR2)+
    geom_point(mapping = aes(x=month,y=abundance))+
    facet_wrap(vars(year));
  #larval dataplot
  larvFishDR1 <- larvFishDR1 %>% filter(year %in% c(2010,2014,2015,2016))
  write_csv(larvFishDR1,
            "data/whitesucker_final.csv")
  fakedata <- data.frame(daynum = unique(pauldat$daynum),abundance = 0);
  larvFishDR2 <- larvFishDR2 %>% filter(year %in% c(2011,2014,2015,2016))
  write_csv(larvFishDR2,
            "data/whitebass_final.csv")
  
  
  write_csv(fakedata, file = "data/fakeLarvalData.csv");
  
  fakedata <- read_csv("data/fakeLarvalData.csv");
  
  ggplot(fakedata)+
    geom_point(mapping = aes(x=daynum,y=abundance));
  
}








#plotting  zooplankton abundance and larval fish abundance
{
  rm(list=ls());
  options(show.error.locations=TRUE);
  
  library(tidyverse)
  library(lubridate)
  
  data <- read_csv("data/cascade_zooplankton_v0.5_upload.csv");
  
  paulLakeRows = which(data$lakename == "Paul Lake");
  pauldat = data[paulLakeRows,];
  
  #pauldat <- data %>% filter(lakename == "Paul Lake");
  
  cladCodeRows = which(pauldat$group_code == "CLAD");
  
  ggplot(data=pauldat[cladCodeRows, ])+
    geom_point(mapping = aes(x= daynum, y=abundance, colour=as.character(year4)));
  
  # ggplot(data=pauldat %>% filter(group_code == "CLAD"))+
  #   geom_point(mapping = aes(x= daynum,y=abundance,colour = as.character(year4)));
  
  # why does it not group by group_code?
  pauldat0 = group_by(.data=pauldat, year4,daynum,group_code);
  pauldat1 = summarize(.data=pauldat0, abund=sum(abundance));

  p0 = aggregate(formula=abundance~group_code+daynum+year4, data=pauldat, FUN=sum);
  
  pauldat11 <- pauldat %>% group_by(year4,daynum,group_code) %>%
    summarise(
      abundance = sum(abundance)
    );
  unique(pauldat1$group_code);
  
  cladCodeRows2 = which(pauldat1$group_code == "CLAD");
  
  ggplot(data=pauldat1[cladCodeRows2, ])+
    geom_point(mapping = aes(x=daynum, y=abundance, colour=as.character(year4)));
  
  # ggplot(data=pauldat1 %>% filter(group_code == "CLAD"))+
  #   geom_point(mapping = aes(x= daynum,y=abundance,colour = as.character(year4)));
  
  cladCodeYear4Rows = which(pauldat1$group_code == "CLAD" & pauldat1$year4 >=2000);
  ggplot(data=pauldat1[cladCodeYear4Rows, ])+
    geom_point(mapping = aes(x=daynum, y=abundance, colour=as.character(year4)));
  
  # ggplot(data=pauldat1 %>% filter(group_code == "CLAD" & year4 >=2000))+
  #   geom_point(mapping = aes(x= daynum,y=abundance,colour = as.character(year4)));
  
  ggplot(data=pauldat1[cladCodeYear4Rows, ])+
    geom_point(mapping = aes(x=daynum, y=abundance))+
    facet_wrap(vars(year4));
  
  # ggplot(data=pauldat1 %>% filter(group_code == "CLAD" & year4 >=2000))+
  #   geom_point(mapping = aes(x= daynum,y=abundance))+
  #   facet_wrap(vars(year4));
  
  cladCodeYear4Rows2 = which(pauldat1$group_code == "CLAD" & pauldat1$year4 <=2000);
  
  ggplot(data=pauldat1[cladCodeYear4Rows2, ])+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  # ggplot(data=pauldat1 %>% filter(group_code == "CLAD" & year4 <=2000))+
  #   geom_point(mapping = aes(x= daynum,y=abundance))+
  #   facet_wrap(vars(year4));
  
  ocopYear4Rows = which(pauldat1$group_code == "OCOP" & pauldat1$year4 >=2000);
  ocopYear4Rows2 = which(pauldat1$group_code == "OCOP" & pauldat1$year4 <=2000);
  
  ggplot(data=pauldat1[ocopYear4Rows, ])+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  ggplot(data=pauldat1[ocopYear4Rows2, ])+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
  # ggplot(data=pauldat1 %>% filter(group_code == "OCOP" & year4 >=2000))+
  #   geom_point(mapping = aes(x= daynum,y=abundance))+
  #   facet_wrap(vars(year4));
  # 
  # ggplot(data=pauldat1 %>% filter(group_code == "OCOP" & year4 <=2000))+
  #   geom_point(mapping = aes(x= daynum,y=abundance))+
  #   facet_wrap(vars(year4));
  
  peterdat <- data %>% filter(lakename == "Peter Lake")
  peterdat1 <- peterdat %>% group_by(year4,daynum,group_code) %>% 
    summarise(
      abundance = sum(abundance)
    );
  
  ggplot(data=peterdat1 %>% filter(group_code == "CLAD" & year4 >=2000))+
    geom_point(mapping = aes(x= daynum,y=abundance))+
    facet_wrap(vars(year4));
  
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
  
  larvFishDR1 <- larvFishDR %>% group_by(year,month,day) %>% 
    summarise(
      abundance = sum(LarvalSum)
    );
  
  ggplot(data = larvFishDR1 %>% filter(year==2015))+
    geom_point(mapping = aes(x=day,y=abundance));
  
  ggplot(data = larvFishDR1)+
    geom_point(mapping = aes(x=day,y=abundance))+
    facet_wrap(vars(year));
  
  
  fakedata <- data.frame(daynum = unique(pauldat$daynum),abundance = 0);
  
  write_csv(fakedata, file = "data/fakeLarvalData.csv");
  
  fakedata <- read_csv("data/fakeLarvalData.csv");
  
  ggplot(fakedata)+
    geom_point(mapping = aes(x=daynum,y=abundance));
  
}








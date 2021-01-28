{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);

  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  # Part 2 Teaching goals ####
  # - subset data
  # - plotting data as lines
  # - axis labels
  # - themes
  # - alternative way to display months 
  
  # subset data and color is used as a style change here -- it is not mapped to data
  year2008 = which(abundanceData$year == 2008);
  
  plot2 = ggplot(data=abundanceData[year2008,])+
    geom_line(mapping=aes(x=month, y=zooplankton),
              color="red",
              size=1.5,
              linetype="solid") +   # linetypes: http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software
    theme_bw() +
    scale_x_continuous(breaks=1:12, # Different way to display months
                       labels= month.abb) +
    labs(title="Plot 2",
         subtitle="Zooplankton abundance 2008",
         y="Number of Zooplankton");
  plot(plot2);
  
  # 3 conditions being used to subset the data
  year2008_sub = which(abundanceData$year == 2008 &
                       abundanceData$month >= 4 &     # 4th month: April
                       abundanceData$month <= 9);     # 9th month: Sept
  
  plot2b = ggplot(data=abundanceData[year2008_sub,])+
    geom_line(mapping=aes(x=month, y=zooplankton),
              color="red",
              size=1.5,
              linetype="solid") +  
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="plot 2b",
         subtitle="Zooplankton abundance 2008 - Apr to Sept",
         y="Number of Zooplankton");
  plot(plot2b);
  
}

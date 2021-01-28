{
  #PARTS 1 & 2 ACTIVITY -- MAPPING, SUBSETTING, THEMES, AND LABELING
  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  #########
  # TASKS #
  #########
  
  # (1) Subset the data from March to October for 2010
  #
  # (2) Map larval white bass abundance to the y axis
  #
  # (3) Use a dashed line
  #
  # (4) Make this line blue
  #
  # (5) Pick a theme different from the default
  #
  # (6) Give your plot a title and subtitle
  
  # subset data and color is used as a style change here -- it is not mapped to data
  year2010_sub = which(abundanceData$year == 2010 &
                         abundanceData$month>=3 &  #3rd month is March
                         abundanceData$month<=10); #10th month is October
  
  solution = ggplot(data=abundanceData[year2010_sub,])+
    geom_line(mapping=aes(x=month, y=zooplankton), #be sure to map the correct column the y-axis
              color="blue",
              size=2,
              linetype="dashed") +   # linetypes: http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software
    theme_classic() + #any theme of your choosing works here.
    scale_x_continuous(breaks=1:12, # Different way to display months
                       labels= month.abb) +
    labs(title="zooplankton Abundance",#Use title and subtitle to label the plot correctly.
         subtitle="2010 Mar - Oct", 
         y="zooplankton");
  plot(solution);
  
}
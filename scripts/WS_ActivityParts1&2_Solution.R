{  
  #PARTS 1 & 2 ACTIVITY -- MAPPING, SUBSETTING, THEMES, AND LABELING
  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  ############
  # Activity #
  ############
  
  # This time, we’ll be using the larval white bass data. 
  #
  #   (1) Subset the data set from March to October for the year 2010.
  #
  #   (2) Pick and implement one of the two methods labeling months on the x axis
  #
  #   (3) Map the larval white bass abundance to the y-axis instead of zooplankton abundance.
  #
  #   (4) Make it a line plot, and use a blue, dashed line (or non-default linetype).
  #
  #   (5) Select a theme for your plot that is different from the default 
  #
  #   (6) Label and sublabel your plots to match the data plotted 
  
  # subset data and color is used as a style change here -- it is not mapped to data
  year2010_sub = which(abundanceData$year == 2010 &
                     abundanceData$month>=3 &  #3rd month is March
                     abundanceData$month<=10); #10th month is October
  
  solution = ggplot(data=abundanceData[year2010_sub,])+
    geom_line(mapping=aes(x=month, y=whitebass), #be sure to map the correct column the y-axis
              color="blue",
              size=2,
              linetype="dashed") +   # linetypes: http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software
    theme_classic() + #any theme of your choosing works here.
    scale_x_continuous(breaks=1:12, # Different way to display months
                       labels= month.abb) +
    labs(title="Larval White Bass Abundance",#Use title and subtitle to label the plot correctly.
         subtitle="2010 Mar - Oct", 
         y="Number of Larval White Bass");
  plot(solution);
  
}
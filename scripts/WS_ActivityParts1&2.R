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
  #   (1) Subset the data set from March to October for the year 2010.
  #
  #   (2) Pick and implement one of the two methods labeling months on the x axis
  #
  #   (2) Map the larval white bass abundance to the y-axis instead of zooplankton abundance.
  #
  #   (3) Make it a line plot, and use a blue, dashed line (or non-default linetype).
  #
  #   (4) Select a theme for your plot that is different from the default 
  #
  #   (5) Label and sublabel your plots to match the data plotted 
  
  
  # subset data and color is used as a style change here -- it is not mapped to data
  year2010_sub = which();
  
  solution = ggplot(data=)+
    geom_line(mapping=aes(x=, y=), #be sure to map the correct column the y-axis
              color="",
              size=,
              linetype="") +   # linetypes: http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software
    labs(title="",#Use title and subtitle to label the plot correctly.
         subtitle="", 
         y="");
  plot(solution);
  
  
}
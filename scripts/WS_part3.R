{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
 
  
  # Part 3 Teaching goals ####
  # - mapping a 3rd variable (year to color) 
  # - continuous vs discrete mapping
  # - creating legend (done by 3rd variable mapping)
  # - labeling and moving legends
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                      abundanceData$month <= 9);    
  
  # color is used as a mapping variable to map the 4 years to the plot --
  plot3 = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color=year),  # mapping color to year (this is a problem...)
              #    color="blue",   # leaving this in will conflict with the color mapping
              size=1.5,
              linetype=1) +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Zooplankton abundance",
         subtitle="2008-2011",
         x="Month by Number",
         y="Number of Zooplankton");
  plot(plot3);
  
  # Issue: year is numeric and GGPlot treats it as continuous
  #        We want to make it discrete, or a factor
  plot3b = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color=factor(year)),
              size=1.5,
              linetype=1) +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Zooplankton abundance",
         subtitle="2008-2011",
         x="Month by Number",
         y="Number of Zooplankton",
         color="--Year--"); # if you don't have this, the label will be factor(year)
  plot(plot3b);
  
  # The third mapped variable can also map linetype -- also moved the legend
  plot3c = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, linetype=factor(year)),
              size=1.25) +
    theme_minimal() +
    theme(legend.position = c(.1,.8),          # change legend placement 
          legend.key.width = unit(3,"cm")) +   # change legend width
    labs(title="Zooplankton abundance",
         subtitle="2008-2011",
         x="Month by Number",
         y="Number of Zooplankton",
         linetype="Year");
  plot(plot3c);
  
}

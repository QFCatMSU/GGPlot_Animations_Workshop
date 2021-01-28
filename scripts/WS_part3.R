{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
 
  
  # Part 3 Teaching goals ####
  # - Mapping a 3rd variable (year to color) 
  # - Continuous vs discrete mapping
  # - Creating legend (done by 3rd variable mapping)
  # - Manually changing color and linetype
  # - Labeling and moving legends
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                      abundanceData$month <= 9);    
  
  # color is used as a mapping variable to map the 4 years to the plot --
  plot3a = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color=year),  # mapping color to year (this is a problem...)
              #    color="blue",   # leaving this in will conflict with the color mapping
              size=1.5,
              linetype=1) +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Plot 3a",
         subtitle="Zooplankton Abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton");
  plot(plot3a);
  
  # Issue: year is numeric and GGPlot treats it as continuous
  #        We want to make it discrete, or a factor
  plot3b = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color=factor(year)),
              size=1.5,
              linetype=1) +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Plot 3b",
         subtitle="Zooplankton Abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton")
  plot(plot3b);
  
  #Using default colors may be problematic; here, we set the colors manually
  plot3c = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color=factor(year)),
              size=2,
              linetype=1) +
    scale_color_manual(values=c("2008"="grey80","2009"="grey60","2010"="grey40","2011"="grey20")) +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Plot 3c",
         subtitle="Zooplankton Abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton",
         color="--Year--"); # if you don't have this, the label will be factor(year)
  plot(plot3c);
  
  # The third mapped variable can also map linetype -- also moved the legend
  plot3d = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, linetype=factor(year)),
              size=1.25) +
    theme_minimal() +
    theme(legend.position = c(.15,.8)) +         # change legend placement 
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Plot 3d",
         subtitle="Zooplankton Abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton",
         linetype="Year");
  plot(plot3d);
  
  # The third mapped variable can also map linetype -- also moved the legend
  plot3e = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, linetype=factor(year)),
              size=1.25) +
    theme_minimal() +
    theme(legend.position = c(.15,.8),          # change legend placement 
          legend.key.width = unit(3,"cm")) +   # change legend width
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    scale_linetype_manual(values=c("2008"="solid","2009"="longdash","2010"="dashed","2011"="dotted")) +
    labs(title="Plot 3e",
         subtitle="Zooplankton Abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton",
         linetype="Year");
  plot(plot3e);
  
}

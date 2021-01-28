{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                        abundanceData$month <= 9);    
  
  # Part 4 Teaching goals ####
  # - Mapping multiple plots (faceting)
  # - Plotting additional data (two lines)
  # - Scaling the data
  # - Changing y-axis number notation
  # - Adding a secondary axis
  
  # Create a separate plot for each year (faceting)
  plot4a = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton),
              size=1.25) +
    facet_wrap(facets = ~year) +   # breaks the plots up by year
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Plot 4a",
         subtitle="Zooplankton Abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton");
  plot(plot4a);
  
  # Put two lines on each plot
  # color here "maps" the line to the legend under the term in quotes (this is awkward!)
  # This plot obviously has a scale issue!
  plot4b = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass, color="White Bass"), 
              size= 1.25) +
    facet_wrap(facets = ~year) +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Plot 4b",
         subtitle="Zooplankton vs. Larval white bass abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +   # title of the legend
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));  # change line colors
  plot(plot4b);
  
  # there are NA values in the data frame that we need to deal with
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm=TRUE) /
                 max(abundanceData$zooplankton, na.rm=TRUE);
  
  # adjust scale and color, change 
  plot4c = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass/coeff_WB_Zoo, color="White Bass"), 
              size= 1.25) +
    facet_wrap(facets = ~year) +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    scale_y_continuous(labels = scales::comma) +  # change to regular notation
    theme_bw() +
    labs(title="Plot 4c",
         subtitle="Zooplankton vs. Larval white bass abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));  # change line colors
  plot(plot4c);
  
  # add secondary axis
  plot4d = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass/coeff_WB_Zoo, color="White Bass"), 
              size= 1.25) +
    scale_y_continuous(name = "Zooplankton abundance",              # first axis
                       labels = scales::comma, # change to regular notation
                       sec.axis = sec_axis(trans= ~.*coeff_WB_Zoo,  # second axis
                                           name="Larval white bass abundance",
                                           labels = scales::comma)) +
    facet_wrap(facets = ~year) +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    theme_bw() +
    labs(title="Plot 4d",
         subtitle="Zooplankton vs. Larval white bass abundance 2008 - 2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));
  plot(plot4d);
} 

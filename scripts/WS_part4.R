{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                        abundanceData$month <= 9);    
  
  # Part 4 Teaching goals ####
  # - mapping multiple plot (color maps to legend)
  # - scaling math 
  # - overriding legend colors
  # - faceting
  # - change number notation
  # - secondary axis (advanced)
  
  # Create a separate plot for each year (faceting)
  plot4 = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton),
              size=1.25) +
    facet_wrap(facets = ~year) +   # breaks the plots up by year
    theme_minimal() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Zooplankton Abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton");
  plot(plot4);
  
  # Put two lines on each plot
  # color here "maps" the line to the legend under the term in quotes (this is awkward!)
  # This plot obviously has a scale issue!
  plot4b = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass, color="White Bass"), 
              size= 1.25) +
    facet_wrap(facets = ~year) +
    theme_minimal() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Zooplankton vs. White bass abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species");    # title of the legend
  plot(plot4b);
  
  # there are NA values in the data frame that we need to deal with
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm=TRUE) /       # do not use T!
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
    theme_minimal() +
    labs(title="Zooplankton vs. White bass abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));  # change line colors
  plot(plot4c);
  
  # add secondary axis (***advanced***)
  plot4d = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass/coeff_WB_Zoo, color="White Bass"), 
              size= 1.25) +
    scale_y_continuous(name = "Zooplankton abundance",              # first axis
                       labels = scales::comma, # change to regular notation
                       sec.axis = sec_axis(trans= ~.*coeff_WB_Zoo,  # second axis
                                           name="White Bass abundance")) +
    facet_wrap(facets = ~year) +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    theme_minimal() +
    labs(title="Zooplankton vs. White bass abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));
  plot(plot4d);
} 

{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  ############
  # Activity #
  ############
  
  # This time, we’ll be using the larval white sucker data. 
  #
  #   (1) Subset the data set from April to September.
  #
  #   (2) Plot month vs zooplankton and larval white sucker abundance.
  #
  #   (3) Create a separate plot for each year by faceting.
  #
  #   (4) Add a second axis for the white sucker abundance; you will need 
  #       to calculate a new scaling coefficient here, using the same method 
  #       that was used to calculate the scaling coefficient for the larval 
  #       white bass data. 
  #
  #   (5) Change the color of the lines and the theme of the plot as you see 
  #       fit, making sure to reflect this in the legend. 
  
  
  ############
  # Solution #
  ############
  
  # Subset the Data Set From April to September
  apr_to_sept = which(abundanceData$month >= 4 &    
                      abundanceData$month <= 9);
  
  # Create the scaling coefficient
  WS_zoop_coeff = max(abundanceData$whitesucker, na.rm=TRUE) /  
                  max(abundanceData$zooplankton, na.rm=TRUE);
  
  plot4 = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"), #Zooplankton
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitesucker/WS_zoop_coeff, color="White Sucker"), #White Sucker
              size=1.25) +
    facet_wrap(facets = ~year) +
    theme_light() + #Change the theme
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    scale_y_continuous(name = "Zooplankton Abundance",              # first axis
                       sec.axis = sec_axis(trans= ~.*WS_zoop_coeff,  # second axis
                                           name="Larval White Sucker Abundance")) +
    scale_color_manual(values=c("White Sucker"="Blue","Zooplankton"="Orange")) + #Change the line colors
    labs(title="Zooplankton vs. Larval White Sucker Abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species");
  plot(plot4);
  
}

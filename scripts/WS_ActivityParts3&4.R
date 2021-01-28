{  
  #PARTS 3 & 4 ACTIVITY -- FACETING, SCALING, AND SECONDARY AXES
  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  abundanceData = read.csv(file="data/abundance.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  #########
  # TASKS #
  #########
  
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
  
  # Subset the Data Set From April to September
  apr_to_sept = which();
  
  # Create the scaling coefficient
  WS_zoop_coeff = max() /  
                  max();
  
  solution = ggplot(data=)+
    geom_line(mapping=aes(x=month, y=, color=),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=, color=),
              size=1.25) +
    facet_wrap(facets = ) +
    scale_color_manual(values=c()) +
    theme_light() + 
    scale_y_continuous(name = ,
                       labels = scales::comma,
                       sec.axis = sec_axis(trans= ~.*,
                                           labels=scales::comma,
                                           name=)) +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Zooplankton vs. Larval White Sucker Abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species");
  plot(solution);
  
}

{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  
  # Part 1 Teaching goals ####
  # - parameters for read.csv
  # - plotting data as points
  # - styling the points (just comment about this)
  # - titles and labels
  # - using month abbreviations (factors)
  
  # the parameters are not necessary needed but I think it is important to know about them
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  # just print out the points of data
  plot1 = ggplot(data=abundanceData) +              # canvas created and data frame established
    geom_point(mapping=aes(x=month, y=zooplankton), # columns from the data frame
               color="blue",   # may color names work here: https://stat.columbia.edu/~tzheng/files/Rcolor.pdf
               size=2,         # multiplier (x2)
               shape=1) +      # can use values 1-25: http://www.sthda.com/english/wiki/ggplot2-point-shapes
    labs(title="Zooplankton abundance",
         subtitle="2008-2011");
  plot(plot1);
  
  # change the month number to month abbreviation 
  # R's built in constants (it's not much...): https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Constants
  plot1b = ggplot(data=abundanceData)+
    geom_point(mapping=aes(x=month.abb[month], y=zooplankton),
               color="blue",
               size=2,
               shape=1) +  # can use values 1-6
    labs(title="Zooplankton abundance",
         subtitle="2008-2011");
  plot(plot1b);
  # Two problems with the above plot:
  # 1) The months are given alphabetically (default ordering for strings in R)
  # 2) The x-axis label changed to what x is equal to
  
  # one step at a time -- and can see results in Environment
  months = month.abb[abundanceData$month];    # type month.abb, month.abb[2], month.abb[c(2,5)] in Console
  months2 = factor(months, levels=month.abb); # months in order -- levels force the order

  plot1c = ggplot(data=abundanceData) +
    geom_point(mapping=aes(x=months2, y=zooplankton),
               color="blue",
               size=2,
               shape=1) +   
    labs(title="Zooplankton abundance",
         subtitle="2008-2011",
         x="Month");   # set x-axis label manually
  plot(plot1c);
  
  # Should we talk about the warning messages when plotting?=
}

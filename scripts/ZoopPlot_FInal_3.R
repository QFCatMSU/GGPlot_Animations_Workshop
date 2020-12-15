# I added parameter names to all functions
# How important is it to show a legend?  An alternative is to add the legend text to the plot.

{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  library(package=transformr);  # tweens the animations (does not do anything with lines...)
  library(package=gganimate);
  library(package=av);          # to create mp4 videos
  
  # Part 1 Teaching goals ####
  # - parameters for read.csv
  # - plotting data as points
  # - styling the points (just comment about this)
  # - titles and labels
  # - using month abbreviations
  
  # R's built in constants (it's not much...): https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Constants
  
  # the parameters are not necessary needed but I think it is important to know about them
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  # just print out the points of data
  plot1 = ggplot(data=abundanceData)+
    geom_point(mapping=aes(x=month, y=zooplankton),
               color="blue",
               size=2,     # multiplier (x2)
               shape=1) +  # can use values 1-6 for different shapes
    labs(title="Zooplankton abundance",
         subtitle="2008-2011");
  plot1;
  # Maguffee - Charlie, I'm having a hard time seeing the points here. Changed the color
  #           to blue instead. Change Month label to actual months. I like showing off
  #           multiple features here, will definitely save some time.
  
  # Charlie: I agree -- the switch to month abbreviated should be here (maybe a 1b)
  # Connor : Not a huge fan of the "X" shape type, but not super important.

  # change the month number to month abbreviation 
  plot1b = ggplot(data=abundanceData)+
    geom_point(mapping=aes(x=month.abb[month], y=zooplankton),
               color="blue",
               size=2,
               shape=1) +  # can use values 1-6
    labs(title="Zooplankton abundance",
         subtitle="2008-2011");
  plot1b;
  # Two problems with the above:
  # 1) The months are given alphabetiucally
  # 2) The x-axis label changed to what x is equal to
  
  # one step at a time -- and can see results in Environment
  months = month.abb[abundanceData$month];
  months2 = factor(months, levels=month.abb); # months in order

  plot1c = ggplot(data=abundanceData)+
    geom_point(mapping=aes(x=months2, y=zooplankton),
               color="blue",
               size=2,
               shape=1) +  # can use values 1-6
    labs(title="Zooplankton abundance",
         subtitle="2008-2011",
         x="Month");
  plot1c;
  
  
  # Part 2 Teaching goals ####
  # - subset data
  # - plotting data as lines
  # - axis labels
  # - themes
  
  # subset data and color is used as a style change here -- it is not mapped to data
  year2008 = which(abundanceData$year == 2008);
  
  plot2 = ggplot(data=abundanceData[year2008,])+
    geom_line(mapping=aes(x=month, y=zooplankton),
              color="red",
              size=1.5,
              linetype=1) +   # can use #1-6
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    labs(title="Zooplankton abundance",
         subtitle="2008",
   #      x="Month",
         y="Number of Zooplankton");
  plot2
  # Maguffee - Line type looked too close to a point plot; changed the line type to 2.
  #           I still think we should be plotting by month rather than month number;
  #           labels should reflect that.
  
  # Connor: I agree with the above, should change it to a labeled factor
  
  # Part 3 Teaching goals ####
  # - mapping a 3rd variable (year to color)
  # - continuous vs discrete mapping
  # - legend
  # - labels on a legend
  
  # color is used as a mapping variable to map the 4 years to the plot --
  # if you just do color=year then year will be treated as a continuous value (try it!)
  plot3 = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=month, y=zooplankton, color=as.factor(year)),
  #            color="blue",   # leaving this in will cause problems!
              size=1.5,
              linetype=2) +
    theme_bw() +
    labs(title="Zooplankton abundance",
         subtitle="2008",
         x="Month by Number",
         y="Number of Zooplankton",
         color="Year"); # if you don't have this, the label will be as.factor(year)
  plot3
  
  # Connor: While I like the idea of playing around with the linetype/color,
  # this one is also difficult and I think it should be solid
  
  # Can also map linetype or size
  plot3b = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=month, y=zooplankton, linetype=as.factor(year)),
              size=1.25) +
    theme_minimal() +
    theme(legend.position = c(.8,.8),          # change placement 
          legend.key.width = unit(3,"cm")) +   # change width
    labs(title="Zooplankton abundance",
         subtitle="2008",
         x="Month by Number",
         y="Number of Zooplankton",
         linetype="Year");
  plot3b
  #Maguffee - For the color blind, is there a way to specify color? In a way, I guess that's
  #           the point of plot 3b. I had to change the size of the lines in plot 3b, couldn't
  #           see them very well. By doing this, however, the legend became useless. Any way
  #           to fix that?
  
  # Charlie --
  #   Color blind: the answer is yes...but not worth it here
  #   Legend: I modified it -- the answer to questions like these are often "in the theme()"
  
  
  # Part 4 Teaching goals ####
  # - mapping multiple plot (color maps to legend)
  # - secondary axis
  # - scaling math
  # - overriding legend colors
  # - facetting

  # color here "maps" the line to the legend under the term in quotes
  # I find this to be an awkward feature of GGPlot
  # And this plot obviously has a scale issue!
  plot4 = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass, color="White Bass"), 
              size= 1.25) +
    facet_wrap(facets = ~year) +
    theme_minimal() +
    labs(title="Zooplankton vs. White bass abundance",
         subtitle="2008-2011",
         x="Month by Number",
         y="Number of Zooplankton",
         color="Species");
  plot4;
  
  # there is now NA values in the data frame that we need to deal with
  coeff_WS_Zoo = max(abundanceData$whitesucker, na.rm=TRUE) /  # do not use T!
    max(abundanceData$zooplankton, na.rm=TRUE);
  
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm=TRUE) /  
    max(abundanceData$zooplankton, na.rm=TRUE);
  
  # add secondary axis, adjust scale and color, change month too abb
  plot4b = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass/coeff_WB_Zoo, color="White Bass"), 
              size= 1.25) +
    scale_y_continuous(name = "Zooplankton abundance",              # first axis
                       labels = scales::comma, # change to regular notation
                       sec.axis = sec_axis(trans= ~.*coeff_WB_Zoo,  # second axis
                                           name="White Bass abundance")) +
    facet_wrap(facets = ~year) +
    theme_minimal() +
    labs(title="Zooplankton vs. White bass abundance",
         subtitle="2008-2011",
         x="Month by Number",
         y="Number of Zooplankton",
         color="Species") +
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));
  plot4b;
  #Maguffee - I like the explanation here for the workaround for two axes plotting in ggplot.
  #           One thing I would maybe consider would be to represent the zooplankton abundance
  #           without scientific notation. Is there a way to do this that makes it easy to read?
  
  # Charlie
  #   Change to regular notation -- unusure which way I like...

  # Part 5 Teaching goals ####
  # - months -- abbreviating and factoring 
  # - transitioning (animation)
  # - group mapping (this seems so unnecessary...)
  # - closest_state (year printed on plot)
  # - RStudio Plots vs Viewer Tabs
  
  # get the abbreviations for months
  months = month.abb[abundanceData$month];  # this will give you months alphabetically
  months2 = factor(month.abb[abundanceData$month],levels=month.abb); # months in order
  
  # To animate lines, we need to add "group" to the mapping
  # I do not know why -- this is also awkward!
  # I also switched from month numbers to month but this has 2 steps:
  #   1) convert numbers to month using month.abb
  #   2) Order the months by time instead of alphabetically
  # We will need to break this down if we teach it!
  plot5 = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=months2, y=zooplankton, 
                          group=year, color="Zooplankton")) +
    geom_line(mapping=aes(x=months2, y=whitebass/coeff_WB_Zoo, 
                          group=year, color="White Bass")) +
    scale_y_continuous(name = "Zooplankton abundance",             # first axis
                       sec.axis = sec_axis(trans= ~.*coeff_WB_Zoo,  # second axis
                                           name="White Bass abundance")) +
    labs(title="Zooplankton vs. White bass abundance",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    theme_bw() +
    transition_states(states = year,         # year is a column in weatherData
                      transition_length = 1, # relative animation time (default: 1)  
                      state_length = 2,      # relative pause time (default: 1)
                      wrap = TRUE);          # gif always wraps so this is useless  
  plot5;
  
  # Using lines in an animations produced a much different visual effect because
  # gganimate does not transition between the lines like it does with points, 
  # it just pops one line out of existence and puts the next line in. 
  
  #Maguffee - I think this looks fine. Definitely not a striking visual effect like animating
  #           with points, but it's a good starting point, and I think it works well with
  #           our example. I think we need to spend some time on this section.
  
  # Connor: I think its worth considering using points to get that effect. Mostly because I think
  # it looks cooler.
  
  plot(plot1);
  plot(plot1b);
  plot(plot1c);
  plot(plot2);
  plot(plot3);
  plot(plot3b);
  # plot(plot4);
  # plot(plot4b);
  # print(plot5);
  
  # Part 6 Teaching goals ####
  # - file saving
  # - gifs and mp4
  
  # 
  # # anim_save() also take parameters from animate()
  # anim_save(filename="media/abundance.gif",
  #           animation = plotAnim);
  # 
  # # anim_save() -- saving as an mp4 video
  # anim_save(filename = "media/abundance.mp4",
  #           animation = plotAnim,
  #           renderer = av_renderer(),
  #           nframes = 60,       # number of frames in animation
  #           fps = 3);           # frames per second
}

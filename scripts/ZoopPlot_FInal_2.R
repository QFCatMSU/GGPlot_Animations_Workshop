# I added parameter names to all functions
# How important is it to show a legend?  An alternative is to add the legend text to the plot.

{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  library(package=transformr);  # tweens the animations (does not do anything with lines...)
  library(package=gganimate);
  library(package=av);          # to create mp4 videos
  
  # not necessary needed but I think it is important to know about these parameters
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  # there is now NA values in the data frame that we need to deal with
  coeffWS_Zoo = max(abundanceData$whitesucker, na.rm=TRUE) /  # do not use T!
                max(abundanceData$zooplankton, na.rm=TRUE);
  
  coeffWB_Zoo = max(abundanceData$whitebass, na.rm=TRUE) /  
                max(abundanceData$zooplankton, na.rm=TRUE);
  
  
  # subset data and color is used as a style change here -- it is not mapped to data
  year2008 = which(abundanceData$year == 2008);
  
  plot0 = ggplot(data=abundanceData[year2008,])+
    geom_line(mapping=aes(x=month, y=zooplankton),
              color="red") +
    labs(title="Zooplankton abundance",
         color="Year");
  
  # color is used as a mapping variable to map the 4 years to the plot --
  # if you just do color=year then year will be treated as a continuous value (try it!)
  plot1 = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=month, y=zooplankton, color=as.factor(year)),
              size=1.25) +
    labs(title="Zooplankton abundance",
         color="Year");
  
  # color here "maps" the line to the legend under the term in quotes
  # I find this to be an awkward feature of GGPlot 
  plot2 = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=month, y=zooplankton, color="Zooplankton"),
              size=1.25) +
    geom_line(mapping=aes(x=month, y=whitebass/coeffWB_Zoo, color="White Bass"), 
              size= 1.25) +
    scale_y_continuous(name = "Zooplankton abundance",             # first axis
                       sec.axis = sec_axis(trans= ~.*coeffWB_Zoo,  # second axis
                                           name="White Bass abundance")) +
    facet_wrap(facets = ~year) +
    labs(title="Zooplankton vs. White bass abundance",
         color="Species") +
    scale_color_manual(values=c("White Bass"="blue","Zooplankton"="orange"));

  # To animate lines, we need to add "group" to the mapping
  # I do not know why -- this is also awkward!
  # I also switched from month numbers to month but this has 2 steps:
  #   1) convert numbers to month using month.abb
  #   2) Order the months by time instead of alphabetically
  # We will need to break this down if we teach it!
  plotAnim = ggplot(data=abundanceData)+
    geom_line(mapping=aes(x=factor(month.abb[month],levels=month.abb), y=zooplankton, 
                          group=year, color="Zooplankton")) +
    geom_line(mapping=aes(x=factor(month.abb[month],levels=month.abb), y=whitebass/coeffWB_Zoo, 
                          group=year, color="White Bass")) +
    scale_y_continuous(name = "Zooplankton abundance",             # first axis
                       sec.axis = sec_axis(trans= ~.*coeffWB_Zoo,  # second axis
                                           name="White Bass abundance")) +
    labs(title="Zooplankton vs. White bass abundance by {closest_state}",
         x = "month")  +  # otherwise the label will be: factor(month.abb[month],levels=month.abb
    theme_bw() +
    transition_states(states = year,         # year is a column in weatherData
                      transition_length = 1, # relative animation time (default: 1)  
                      state_length = 2,      # relative pause time (default: 1)
                      wrap = TRUE);          # gif always wraps so this is useless         
  
  # Using lines in an animations produced a much different visual effect because
  # gganimate does not transition between the lines like it does with points, 
  # it just pops one line out of existence and puts the next line in.  
  
  plot(plot0);
  plot(plot1);
  plot(plot2);
  # print(plotAnim);
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


{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  library(package=transformr);  # tweens the animations (does not do anything with lines...)
  library(package=gganimate);
  library(package=av);          # to create mp4 videos
  
  # Part 5 Learning goals ####
  # - Animating with discrete transitions using transition_states (plot5a.1) and transition_reveal (plot5a.2)
  # - Animating with continuous transitions (plot5b.1)
  # - saving as GIF
  # - saving as MP4
  
  # We are going to be running the code, not sourcing!
  # First let"s load the data
  # This should look familiar 
  abundanceData = read.csv(file = "data/abundance.csv", sep = ",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                      abundanceData$month <= 9);   
  
  coeff_WS_Zoo = max(abundanceData$whitesucker, na.rm = TRUE) /
                 max(abundanceData$zooplankton, na.rm = TRUE);
  
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm = TRUE) /  
                 max(abundanceData$zooplankton, na.rm = TRUE);
  
  #Let"s create a vector that orders our month"s correctly
  month = ordered(abundanceData$month, levels = month.abb[]); 
  
  # Let"s start with a similar plot to what we made during Part 4, but this is incomplete!
  # Here, we are grouping by "year" to prepare for plot for when we add an animation component
  plot5a = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x = month, y = whitesucker, 
                          group = year, color="White Sucker")) +
    geom_line(mapping=aes(x = month, y = zooplankton * coeff_WS_Zoo, 
                          group = year, color="Zooplankton")) +
    labs(title = "Plot 5a",
         subtitle = "Zooplankton vs. Larval white sucker abundance",
         x = "Month",
         y = "Number of Zooplankton",
         color = "Species") +
    scale_y_continuous(name = "Larval white sucker abundance",          # first axis
                       sec.axis = sec_axis(trans = ~./coeff_WS_Zoo,     # second axis
                                           name = "Zooplankton abundance",
                                           labels = scales::comma),
                       labels = scales::comma);
  
  # Take a look at our plot as it stands. Not very informative. 
  # We could use facet_wrap to view all four years in separate plots, or we could use animation!
  plot(plot5a)
  
  # Now we have a basic plot, we can add a component that contains what we want to animate across
  # This is the same as adding creating a new ggplot object from scratch
  # Think of this as adding additional layers to the ggplot object!
  plot5a.1 = plot5a +
    # Below, we can overwrite our previous labeling component with a new one that reflects our animation
    # {closest_state} will refer to the varying state
    labs(title = "Plot 5a.1",
         subtitle = "Zooplankton vs. Larval white sucker abundance: {closest_state}", 
         x = "Month",
         y = "Number of Zooplankton",
         color = "Species") +
    theme_bw() +
    scale_x_continuous(breaks = 1:12, 
                       labels = month.abb)+
    transition_states(states = year,         # map animation to the year. Each year is a single frame!
                      transition_length = 1, # relative animation time (default: 1)
                      state_length = 2,      # relative length of the pause between states (default: 1)
                      wrap = TRUE);          # Do you want to the last state to wrap around and start over again? Yes, yes you do.
  
  
  # Let"s pause and take a look at this next function. It can do a lot to modify your animation.
#  ??gganimate::animate;
  
  
  # Now let"s see our beautiful creation!
  animate(plot=plot5a.1, 
          nframes = 50, 
          fps = 3,
          duration=NULL);  # 50 frames / 3 frames per second. 
  
  # Alternatively, we can map animation to the month, and have each state reveal data along that axis
  plot5a.2 = plot5a + 
    transition_reveal(along = month,
                      range=NULL, 
                      keep_last=TRUE) +
    labs(title = "Plot 5a.2",
         subtitle = "Zooplankton vs. Larval white sucker abundance",
         x = "Month",
         y = "Number of Zooplankton",
         color = "Species") +
    theme_bw() +
    scale_x_continuous(breaks = 1:12, 
                       labels = month.abb)+       
    facet_wrap(facets= ~ year);  # and if you like, facet your plot by year
  
  # We might want a few more frames for this type of animation
  # The more frames you add, the smoother the transition, but the longer it takes to render!
  animate(plot=plot5a.2, 
          nframes = 100, 
          fps=10,
          duration=NULL);                    
  
  # Lets take a minute and play around with the nframes and fps. What happens to the animation?
  
  # Now let"s try it with a slightly larger dataset, and a different plot type
  weatherData = read.csv(file = "data/LansingNOAA2016-3.csv", 
                         stringsAsFactors = FALSE);
  
  # Start with our basic ggplot
  plot5b = ggplot(data = weatherData) +
    geom_point(mapping = aes(x = avgTemp, y = relHum)) +
    labs(title = "plot5b",
         subtitle = "Humidity (y) vs. Temperature (x)",
         x = "Average Temp", 
         y = "Humidity") +
    theme_bw();
  
  # Take a look at the base plot first
  plot(plot5b)
  
  # Now add our animation component, animating across increasing precipitation
  plot5b.1 = plot5b + 
    labs(title = "plot5b.1",
         subtitle = "Humidity (y) vs. Temperature (x) by Precipitation: {frame_time} inches",
         x = "Average Temp", 
         y = "Humidity") +
    transition_time(time = precipNum,      # We can transition by a continuous variable too
                    range = NULL);         # Range can be changed to limit the "time"
  
  animate(plot=plot5b.1, 
          nframes = 50, 
          fps=3,
          duration=NULL); 
  
  # Now try animating by day, but let's restrict how many days we want to show
  plot5b.2 = plot5b +
    labs(title = "plot5b.2",
         subtitle = "Humidity (y) vs. Temperature (x) by Day: {frame_time}",
         x = "Average Temp", 
         y = "Humidity") +
    transition_time(time = 1:nrow(weatherData), # each row gets a time slot, which is one day of data!
                    range = c(100L, 200L));     # Range can be changed to limit the "time"
  
  animate(plot=plot5b.2, 
          nframes = 100, 
          fps=1,
          duration=NULL); 
  
  # Let's save our animations that we made, either as a GIF or MP4
  # anim_save() can also take parameters from animate()
  # If on a Mac these files won"t be read with your default viewer -> use your browser to view them!
  
  anim_save(filename = "media/abundance.gif",
            animation = plot5a.2,
            nframes = 100,
            fps = 5);
  
  anim_save(filename = "media/abundance.mp4",
            animation = plot5a.2,
            renderer = av_renderer(),
            nframes = 100,       
            fps = 5); 
}

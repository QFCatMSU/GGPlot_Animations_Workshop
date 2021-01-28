
{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  library(package=transformr);  # tweens the animations (does not do anything with lines...)
  library(package=gganimate);
  library(package=av);          # to create mp4 videos
  
  # Part 5 Learning goals ####
  # - Animating with discrete transitions using transition_states (plot5a.1) 
  #        and transition_reveal (plot5a.2)
  # - Animating with continuous transitions (plot5b.1)
  # - saving as GIF
  # - saving as MP4
  
  # First let's load the data...
  abundanceData = read.csv(file = "data/abundance.csv", sep = ",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                        abundanceData$month <= 9);   
  
  coeff_WS_Zoo = max(abundanceData$whitesucker, na.rm = TRUE) /
    max(abundanceData$zooplankton, na.rm = TRUE);
  
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm = TRUE) /  
    max(abundanceData$zooplankton, na.rm = TRUE);
  
  month = ordered(abundanceData$month, levels = month.abb[])
  
  #
  #
  # Let's start with a similar plot to what we made during Part 4, but this is incomplete!
  plot5a = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x = month, y = whitesucker, 
                          group = year, color="White Sucker")) +          # To animate lines, we need to add "group" to the mapping
    geom_line(mapping=aes(x = month, y = zooplankton * coeff_WS_Zoo, 
                          group = year, color="Zooplankton")) +
    scale_y_continuous(name = "Larval white sucker abundance",          # first axis
                       sec.axis = sec_axis(trans = ~./coeff_WS_Zoo,     # second axis
                                           name = "Zooplankton abundance",
                                           labels = scales::comma),
                       labels = scales::comma);
  #
  #
  # Now we have a basic plot, lets add an animation component 
  plot5a.1 = plot5a +
    labs(title = "Plot 5a.1",
         subtitle = "Zooplankton vs. Larval white sucker abundance: {closest_state}",
         x = "Month",
         y = "Number of Zooplankton",
         color = "Species") +
    theme_bw() +
    scale_x_continuous(breaks = 1:12, 
                       labels = month.abb)+
    transition_states(states = year,         # map animation to the year
                      transition_length = 1, # relative animation time in seconds (default: 1)
                      state_length = 1,      # relative length of the pause between states
                      wrap = TRUE);
  
  plot5a.2 = plot5a + transition_reveal(along = month) +
    labs(title = "Plot 5a.2",
         subtitle = "Zooplankton vs. Larval white sucker abundance ",
         x = "Month",
         y = "Number of Zooplankton",
         color = "Species") +
    theme_bw() +
    scale_x_continuous(breaks = 1:12, 
                       labels = month.abb)+       # map animation to the month, revealing along that axis
    facet_wrap( ~ year);                                       # and if you like, facet your plot by year
  
  animate(plot5a.1, nframes = 60);                      # Number of frames in animation 
  animate(plot5a.2, nframes = 60);                     
  
  #
  #
  # Now let's try it with a slightly larger dataset, and a different plot type
  weatherData = read.csv(file = "data/LansingNOAA2016-3.csv", stringsAsFactors = FALSE);
  
  day = seq(1:nrow(weatherData));                          # Rename the column of rownumbers to refer to the "day"
  month = ordered(weatherData$month, levels = month.abb[]);    # First, make sure your grouping factors are in the correct order
  season = ordered(weatherData$season, levels = c("Winter","Spring","Summer","Fall"));
  
  plot5b = ggplot(data = weatherData) +
    geom_point(mapping = aes(x = avgTemp, y = relHum, group = precipNum)) +
    labs(title = paste('Humidity (y) vs. Temperature (x) by Precipitation (animation)'),
         subtitle = 'Precipitation: {frame_time} inches',
         x = 'Average Temp', 
         y = 'Humidity') +
    theme_bw() +
    scale_x_continuous() +
    scale_y_continuous();
  
  plot(plot5b)
  
  plot5b.1 = plot5b + transition_time(time = precipNum,      # We can transition by a continuous variable too
                                      range = NULL);         # Range can be changed to limit the "time"
  
  animate(plot5b.1, nframes = 60); 
  
 
   # Saving our animated plots 
  # anim_save() can also take parameters from animate()
  anim_save(filename = "media/abundance.gif",
            animation = plot5a.1);
  
  # anim_save() -- saving as an mp4 video
  anim_save(filename = "media/abundance.mp4",
            animation = plot5a.1,
            renderer = av_renderer(),
            nframes = 60,       
            fps = 3);           # frames per second
}

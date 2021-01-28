{
  # PART 5 ACTIVITY -- ANIMATION
  
  rm(list=ls());                         # clear Console Window
  options(show.error.locations = TRUE);  # show line numbers on error
  library(package=ggplot2);
  library(package=gganimate);
  library(package=av);          
  library(package=htmltools);
  library(package=gifski);      
  library(package=transformr);  
  
  weatherData = read.csv(file="data/LansingNOAA2016-3.csv", 
                         stringsAsFactors = FALSE);
  
  #########
  # TASKS #
  #########
  
  # (1) Animate the plot by day
  #
  # (2) Change the plot to animate by month
  #
  # (3) Change the plot to animate by season
  #
  # (4) Change the plot so that the point size varies with precipitation
  #
  # (5) Change the plot so that the color varies with the transition state
  #
  # (6) Adjust the nframes argument. What happens to your plot output?
  #
  # (7) Adjust the fps argument. What happens to your plot output?
  
  day = seq(1:nrow(weatherData))
  month = ordered(weatherData$month, levels=month.abb[]);    # First, make sure your grouping factors are in the correct order
  season = ordered(weatherData$season, levels=c("Winter","Spring","Summer","Fall"));
  
  plot5c = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum, group = , color = ))+
    labs(title = paste('Humidity (y) vs. Temperature (x) by ____ (animation)'),
         subtitle = 'Season: {closest_state}',
         x = 'Average Temp',
         y = 'Humidity') +
    theme_bw()+
    scale_x_continuous() +
    scale_y_continuous();
  
  plot5c.1 = plot5c + transition_states(states = ,
                                        transition_length = ,
                                        state_length = ,
                                        wrap = TRUE);
  
  animate(plot5c.1, nframes = , fps = );
  
  # anim_save() -- saving as a gif
  anim_save(filename = "anim_5c.1.gif",
            animation = plot5c.1,
            nframes = ,       # number of frames in animation
            fps = );           # frames per second
  
  # anim_save() -- saving as an mp4 video
  anim_save(filename = "anim_5c.1.mp4",
            animation = plot5c.1,
            renderer = av_renderer(),
            nframes = ,       # number of frames in animation
            fps = );           # frames per second
  
  # Hints: 
  # Be careful of calling an excessive number of frames, or frames per second
  # Make sure that you appropriately map the group
  
  
  # Notes:
  # - Check out the link below for further tips on the gganimate package
  # - https://github.com/thomasp85/gganimate/wiki
  # - for continuous variables, it is much harder to control transition times
  # - tweening is the term for how animations handle moving points
  
  
  
}

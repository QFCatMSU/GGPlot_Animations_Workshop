{
  rm(list=ls());                         # clear Console Window
  options(show.error.locations = TRUE);  # show line numbers on error

  library(package=ggplot2);
  library(package=gganimate);
  library(package=av);          
  library(package=htmltools);
  library(package=gifski);      
  library(package=transformr);  
  
  # PART 5 ACTIVITY -- ANIMATION
  
  weatherData = read.csv(file="data/LansingNOAA2016-3.csv", 
                         stringsAsFactors = FALSE)[,-1];

  plot1 = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum)) +
    labs(title = paste('Humidity (y) vs. Temperature (x) by Precipitation (animation)'),
         subtitle = 'Precipitation: {frame_time} inches',
         x = 'Average Temp', 
         y = 'Humidity') +
    theme_bw() +
    scale_x_continuous() +
    scale_y_continuous() +
    transition_time(time = precipNum,
                    range = NULL);   # range can be changed to limit the "time"
  animate(plot1, nframes=200);
  
  #
  #
  
  plot2 = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum, color=season))+
    labs(title = paste('Humidity (y) vs. Temperature (x) by Season (animation)'),
         subtitle = 'Season: {closest_state}',
         x = 'Average Temp',
         y = 'Humidity') +
    theme_bw() +
    scale_x_continuous() +
    scale_y_continuous() +
    transition_states(states=season,
                      transition_length = 1,
                      state_length = 2)
    
  animate(plot2, nframes=200);
  
  #
  #
  
  weatherData$month <- factor(weatherData$month, levels=month.name)
  plot3 = ggplot(data=weatherData) +
    geom_point(size=2, mapping=aes(x=avgTemp, y=precipNum, color=month, group=1L))+
    labs(title = paste('Precipitation (y) vs. Temperature (x) by month (animation)'),
         subtitle = 'Month: {closest_state}',
         x = 'Average Temp',
         y = 'Precipitation',
         color = 'Month') +
    theme_bw() +
    scale_x_continuous() +
    scale_y_continuous() +
    scale_color_viridis_d()+
    transition_states(states=month,
                      transition_length = 1,
                      state_length = 2) +
    shadow_trail(distance=0.01)
  
  animate(plot3, nframes=200);
  
  #
  #
  
  # anim_save() -- saving as a gif
  anim_save(filename = "anim_example3.gif",
            animation = plot1,
            nframes = 60,       # number of frames in animation
            fps = 3);           # frames per second
  
  # anim_save() -- saving as an mp4 video
  anim_save(filename = "anim_example4.mp4",
            animation = plot1,
            renderer = av_renderer(),
            nframes = 60,       # number of frames in animation
            fps = 3);           # frames per second

  
  
  
  
  # Notes:
  # - for continuous variables, it is much harder to control transition times
  # - tweening is the term for how animations handle moving points
  


}
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
                         stringsAsFactors = FALSE);
  
  # First, make sure your grouping factors are in the correct order
  colnames(weatherData)[1] <- "day"
  weatherData$month <- ordered(weatherData$month, 
                               levels=month.name)
  weatherData$season <- ordered(weatherData$season, 
                                levels=c("Winter","Spring","Summer","Fall"))
  
  plot5a = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum, group = , color = ))+
    labs(title = paste('Humidity (y) vs. Temperature (x) by Season (animation)'),
         subtitle = 'Season: {closest_state}',
         x = 'Average Temp',
         y = 'Humidity') +
    theme_bw() +
    scale_x_continuous() +
    scale_y_continuous() +
    transition_states(states = day,
                      transition_length = 1,
                      state_length = 1,
                      wrap = TRUE)
  animate(plot5a, nframes = , fps = );
  
  # 1. Change the plot to animate by month
  # 2. Change the plot to animate by season
  # 3. Change the plot so that the point size varies with precipitation
  # 4. Change the plot so that the color varies with the transition state
  # 5. Adjust the nframes argument. What happens to your plot output?
  # 6. Adjust the fps argument. What happens to your plot output?
  
  # anim_save() -- saving as a gif
  anim_save(filename = "anim_5a.gif",
            animation = plot5a,
            nframes = 60,       # number of frames in animation
            fps = 3);           # frames per second
  
  # anim_save() -- saving as an mp4 video
  anim_save(filename = "anim_5a.mp4",
            animation = plot5a,
            renderer = av_renderer(),
            nframes = 60,       # number of frames in animation
            fps = 3);           # frames per second
  
  # Notes:
  # - Check out the link below for further tips on the gganimate package
  # - https://github.com/thomasp85/gganimate/wiki
  # - for continuous variables, it is much harder to control transition times
  # - tweening is the term for how animations handle moving points
  


}

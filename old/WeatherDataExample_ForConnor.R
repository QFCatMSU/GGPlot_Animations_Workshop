{
  rm(list=ls());                         # clear Console Window
  options(show.error.locations = TRUE);  # show line numbers on error

  # make sure to restart RStudio if this is the first time installing these packages
  library(package=ggplot2);
  library(package=gganimate);
  library(package=av);          # to create mp4 videos
  library(package=htmltools);
  library(package=gifski);      # to create animated gifs
  library(package=transformr);  # tweens the animations (does not do anything with lines...)
  
  
  weatherData = read.csv(file="data/LansingNOAA2016-3.csv", 
                         stringsAsFactors = FALSE);



  # create a numeric precipitation column
  precipNum = weatherData$precip;
  precipNum[which(precipNum == "T")] = 0.005;
  weatherData$precipNum = as.numeric(precipNum);
  
  # animation mapping -- using precipNum, a continuous variable
  # frame_time is a "Label variable" (look on cheat sheet)
  plot1 = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum)) +
    labs(title = paste('Humidity (y) vs. Temperature (x) by Precipitation (animation)'),
         subtitle = 'Precipitation: {frame_time} inches',
         x = 'Average Temp', 
         y = 'Humidity') +
    theme_bw() +
    scale_x_continuous() +
    scale_y_continuous() +
    transition_time(time = precip,
                    range = NULL);   # range can be changed to limit the "time"
  print(plot1); 
  
  
  ######Maguffee Code Starts Here
  seasons<-ordered(weatherData$season, levels=c("Spring","Summer","Fall","Winter"))
  
  plot2 = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum)) +
    labs(title = paste('Humidity (y) vs. Temperature (x) by Season (animation)'),
         subtitle = 'Season: {closest_state}',
         x = 'Average Temp',
         y = 'Humidity') +
    theme_bw() +
    transition_states(states=seasons,
                      transition_length = 2,
                      state_length = 4)
    
  print(plot2)
  ################Ends Here
  
  
  
  
  # Notes:
  # - for continuous variables, it is much harder to control transition times
  # - tweening is the term for how animations handle moving points
  
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

}
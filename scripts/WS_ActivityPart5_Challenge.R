rm(list=ls());
options(show.error.locations=TRUE);
library(package=ggplot2);
library(package=gganimate);

weatherData = read.csv(file = "data/LansingNOAA2016-3.csv", 
                       stringsAsFactors = FALSE);

plot5d = ggplot(data=weatherData) +
  geom_point(mapping=aes(x=windSusSpeed, y=changeMaxTemp,
                         group=windDir, color = windDir))+
  theme_bw() +
  labs(title = "plot5d",
       subtitle = "Wind Speed (x) vs. Change in Temp (y) 
                   by wind direction: {closest_state}",
       x = "Wind Speed",
       y = "Change in Temperature") +
  transition_states(states = windDir,
                    transition_length = 1,
                    state_length = 2,
                    wrap = TRUE);
animate(plot=plot5d, 
        nframes = 30, 
        fps=3,
        duration=NULL); 

anim_save(filename = "media/abundance.gif",
          animation = plot5d,
          nframes = 30,
          fps = 5);

{  
  rm(list=ls());
  options(show.error.locations=TRUE);
  library(package=ggplot2);
  library(package=transformr);  # tweens the animations (does not do anything with lines...)
  library(package=gganimate);
  library(package=av);          # to create mp4 videos
  
  abundanceData = read.csv(file="data/final-Charlie.csv", sep=",",
                           header=TRUE, na.strings = c("", NA),
                           stringsAsFactors = FALSE);
  
  apr_to_sept = which(abundanceData$month >= 4 &    
                        abundanceData$month <= 9);   
  
  coeff_WS_Zoo = max(abundanceData$whitesucker, na.rm=TRUE) /
    max(abundanceData$zooplankton, na.rm=TRUE);
  
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm=TRUE) /  
    max(abundanceData$zooplankton, na.rm=TRUE);
  
  # Part 5 Learning goals ####
  # - animations
  # - saving as GIF
  # - saving as MP4

  # To animate lines, we need to add "group" to the mapping
  
  plot5 = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x = month, y = whitesucker, 
                          group=year, color="White Sucker")) +
    geom_line(mapping=aes(x = month, y = zooplankton * coeff_WS_Zoo, 
                          group=year, color="Zooplankton")) +
    scale_y_continuous(name = "Larval white sucker abundance",             # first axis
                       sec.axis = sec_axis(trans = ~./coeff_WS_Zoo,  # second axis
                                           name ="Zooplankton abundance")) +
    labs(title = "Plot 5",
         subtitle = "Zooplankton vs. Larval white sucker abundance",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    theme_bw() +
    scale_x_continuous(breaks = 1:12, 
                       labels = month.abb)
  
  plot5.1 = plot5 + transition_states(states = year,         # map animation to the year
                    transition_length = 1,                 # relative animation time in seconds (default: 1)
                    state_length = 1,                      # relative length of the pause between states
                    wrap = TRUE)
    
  plot5.2 = plot5 + transition_reveal(along = month) +       # map animation to the month, revealing along that axis
                  facet_wrap( ~ year);                     # and if you like, facet your plot by year

  animate(plot5, nframes=60);
  
  #
  #
  
  
  # anim_save() also take parameters from animate()
  anim_save(filename="media/abundance.gif",
            animation = plot5);
  
  # anim_save() -- saving as an mp4 video
  anim_save(filename = "media/abundance.mp4",
            animation = plot5,
            renderer = av_renderer(),
            nframes = 60,       # number of frames in animation
            fps = 3);           # frames per second
}

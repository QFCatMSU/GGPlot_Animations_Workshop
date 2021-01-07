
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
  
  coeff_WS_Zoo = max(abundanceData$whitesucker, na.rm=TRUE) /  # do not use T!
    max(abundanceData$zooplankton, na.rm=TRUE);
  
  coeff_WB_Zoo = max(abundanceData$whitebass, na.rm=TRUE) /  
    max(abundanceData$zooplankton, na.rm=TRUE);
  
  # Part 5 Learning goals ####
  # - animations
  # - saving as GIF
  # - saving as MP4
  # - Locating files in RStudio Projects
  
  # To animate lines, we need to add "group" to the mapping
  #
  plot5 = ggplot(data=abundanceData[apr_to_sept,])+
    geom_line(mapping=aes(x=month, y=whitebass, 
                          group=year, color="White bass")) +
    geom_line(mapping=aes(x=month, y=zooplankton*coeff_WB_Zoo, 
                          group=year, color="Zooplankton")) +
    scale_y_continuous(name = "Larval white bass abundance",             # first axis
                       sec.axis = sec_axis(trans= ~./coeff_WB_Zoo,  # second axis
                                           name="Zooplankton abundance")) +
    labs(title="Zooplankton vs. Larval white bass abundance {closest_state}",
         subtitle="2008-2011",
         x="Month",
         y="Number of Zooplankton",
         color="Species") +
    theme_bw() +
    scale_x_continuous(breaks=1:12, 
                       labels= month.abb) +
    transition_states(states = year,         # map animation to the year
                      transition_length = 1, # relative animation time in seconds (default: 1)
                      state_length = 2);     # relative pause time in seconds (default: 1)

     print(plot5);
  
  # tweak size of gif explain more about tweaks in mp4

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


# Value used to transform the data
coeff <- 10 #Connor - change this to the ratio of the max abundance of zoop : fish

ggplot(data, aes(x=day)) +
  
  geom_line( aes(y=temperature)) + 
  geom_line( aes(y=price / coeff)) + # Divide by 10 to get the same range than the temperature
  
  scale_y_continuous(
    
    # Features of the first axis
    name = "First Axis",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*coeff, name="Second Axis")
  )
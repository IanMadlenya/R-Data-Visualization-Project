# Data Visualization
# A correlation between Corruption and Development
library(ggplot2)
df <- fread("Economist_Assignment_Data.csv", header=TRUE,sep=",", drop = 1)
help(fread)
head(df)

# Use ggplot() + geom_point() to create a scatter plot object called pl.
# You will need to specify x=CPI and y=HDI and color=Region as aesthetics 
pl <- ggplot(df,aes(x=CPI,y=HDI))
pl2 <- pl + geom_point(aes(color=factor(Region)), size = 5, shape = 1) # Shape = 1 means a hollow circle
# Adding a Trend Line using geom_smooth
pl3 <- pl2 + geom_smooth(aes(group = 1), method = lm, formula = y ~ log(x), se = FALSE, color = 'RED')
# Adding labels to the plot using geom_text
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
pl4 <- pl3 + geom_text(aes(label=Country), color = 'gray20', data = subset(df,Country %in% pointsToLabel), check_overlap = TRUE) + theme_bw()
 
pl5 <- pl4 + scale_x_continuous(name = 'Corruption Perceptions Index, 2011(10=least corrupt)', limits = c(.9,10.5), breaks = 1:10)

pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
pl_final <- pl6 + ggtitle('Corruption And Human Development')

# Adding Themes
pl_final + theme_economist_white()

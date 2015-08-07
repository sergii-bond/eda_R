suppressMessages(library(ggplot2))
suppressMessages(library(dplyr))
data(diamonds)
str(diamonds)

ggplot(aes(x = x, y = price), data = diamonds) +
  geom_point()

with(diamonds, cor.test(price, x))
with(diamonds, cor.test(price, y))
with(diamonds, cor.test(price, z))

ggplot(aes(x = depth, y = price), data = diamonds) +
  geom_point(alpha = 0.01) +
  scale_x_continuous(breaks = seq(min(diamonds$depth), max(diamonds$depth), 2))

with(diamonds, cor.test(price, depth))

ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point() +
  scale_x_continuous(limits = c(0, 0.99 * max(diamonds$carat))) +
  scale_y_continuous(limits = c(0, 0.99 * max(diamonds$price))) 

diamonds$volume = with(diamonds, x * y * z)
ggplot(aes(x = volume, y = price), data = diamonds) +
  geom_point() 

library(plyr)
count(diamonds$volume == 0)
detach("package:plyr", unload=TRUE)

d1 = subset(diamonds, volume > 0 & volume < 800)
with(d1, cor.test(price, volume))

ggplot(aes(x = volume, y = price), data = d1) +
  geom_point() +
  geom_smooth(method = 'lm', color = 'red')

# Use the function dplyr package
# to create a new data frame containing
# info on diamonds by clarity.

# Name the data frame diamondsByClarity

# The data frame should contain the following
# variables in this order.

#       (1) mean_price
#       (2) median_price
#       (3) min_price
#       (4) max_price
#       (5) n

# where n is the number of diamonds in each
# level of clarity.

diamondsByClarity <- diamonds %>% group_by(clarity) %>%
  summarize(mean_price = mean(price),
            median_price = median(as.numeric(price)),
            min_price = min(price),
            max_price = max(price),
            n = n()) %>%
  arrange(clarity)

# We’ve created summary data frames with the mean price
# by clarity and color. You can run the code in R to
# verify what data is in the variables diamonds_mp_by_clarity
# and diamonds_mp_by_color.

# Your task is to write additional code to create two bar plots
# on one output image using the grid.arrange() function from the package
# gridExtra.

diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))


library(gridExtra)
p1 <- ggplot(aes(x = clarity, y = mean_price), data = diamonds_mp_by_clarity) +
  geom_bar(stat = "identity")
p2 <- ggplot(aes(x = color, y = mean_price), data = diamonds_mp_by_color) +
  geom_bar(stat = "identity")
grid.arrange(p1, p2, ncol = 2)
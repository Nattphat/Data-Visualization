library(tidyverse)

# review data
mpg

glimpse(mpg)

# ggplot = gg : grammar of graphic
ggplot(data = mpg, mapping = aes(x = cty)) +
  geom_histogram()

ggplot(data = mpg, mapping = aes(x = cty)) +
  geom_density()

ggplot(data = mpg, mapping = aes(x = cty)) +
  geom_boxplot()

# more details ggplot2
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() # scatter plot

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

ggplot(mpg, aes(cty, hwy)) + 
  geom_jitter() + 
  geom_rug() +
  geom_smooth(method = 'lm', se = F) # se : standard error

ggplot(mpg, aes(manufacturer)) +
  geom_bar()

ggplot(mpg, aes(trans)) +
  geom_bar()

mpg %>% 
  count(manufacturer) %>%
  ggplot(., aes(x = reorder(manufacturer, -n), y = n)) + # -n sort desc
  geom_col()

mpg %>% 
  count(trans) %>%
  ggplot(., aes(x = reorder(trans, -n), y = n)) +
  geom_col()

# mapping vs. setting
ggplot(mpg, aes(cty, hwy)) +
  geom_jitter(col = 655,
              size = 5,
              alpha = 0.2) +
  theme_minimal()

# diamonds
glimpse(diamonds)

diamonds %>%
  count(cut)

diamonds %>%
  count(clarity)

# aesthetic mapping
diamonds %>%
  sample_frac(0.1) %>% # sample data
  ggplot(., mapping = aes(carat, price,
                          col = clarity,
                          shape = cut)) +
  geom_point(size = 3, alpha = 0.1) +
  theme_minimal() +
  labs(title = "My first scatter plot",
       subtitile = "R is so cool",
       x = "Carat Diamond",
       y = "Price per Dollar",
       caption = "Data source: ggplot2 diamonds")

# overplotting
diamonds %>%
  sample_n(10000) %>%
  ggplot(., aes(carat, price)) +
  geom_point(alpha = 0.5, shape = "o")

# facet in R
diamonds %>%
  sample_frac(0.1) %>% # sample data
  ggplot(., mapping = aes(carat, price,
                          color = clarity)) +
  geom_point(alpha = 0.2) +
  theme_minimal() +
  facet_wrap( ~cut, nrow = 2,
              ncol = 3)

# facet more than one variable
diamonds %>%
  sample_frac(0.1) %>% # sample data
  ggplot(., mapping = aes(carat, price,)) +
  geom_point(alpha = 0.2) +
  geom_smooth(col = "red") +
  theme_minimal() +
  facet_grid(cut ~ clarity)

# scale color (manual)
# scale color palette

ggplot(mtcars, aes(wt, mpg, 
                   col = factor(am))) +
  geom_point(size = 5)

# name vector
myBrandColors <- c(
  "Auto" = "Gold",
  "Manual" = "Blue"
)

mtcars %>%
  mutate(am = factor(am,
                     levels = c(0,1),
                     labels = c("Auto","Manual"))) %>%
  ggplot(., aes(wt, mpg, col = am)) +
  geom_point(size = 5) +
  scale_color_manual(values = myBrandColors) +
  theme_minimal()

# new chart
# YlGnBu
diamonds %>%
  sample_n(2000) %>%
  ggplot(., aes(carat, price, col = cut)) +
  geom_point(size = 5, alpha = 0.4) +
  theme_minimal() +
  scale_color_brewer(palette ="Pastel1",
                     direction = -1)

# shortcut ggplot => qplot
qplot(x = price, data = diamonds, 
      geom = "histogram",
      bins = 50)

# boxplot ex.
qplot(x = cut, y = price, data = diamonds, 
      geom = "boxplot")

# save ggplot as object
base <- ggplot(diamonds, aes(price))

base + geom_histogram(bins = 100)
base + geom_density()
base + geom_freqpoly()
base + geom_boxplot()

# flip chart
base +
  geom_boxplot(fill = "gold") +
  coord_flip()

# put multiple charts in one canvas
p1 <- qplot(mpg, data = mtcars, geom = "histogram")
p2 <- qplot(wt, mpg, data = mtcars, geom = "point")
p3 <- qplot(mpg, data = mtcars, geom = "density")

library(gridExtra)
grid.arrange(p1, p2, p3, nrow = 1)

# create interactive chart
library(plotly)

myplot <- ggplot(mpg, aes(cty, hwy)) +
  geom_jitter(size = "red") +
  geom_smooth(method = "lm", se = F)

ggplotly(myplot)

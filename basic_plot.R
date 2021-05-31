# library tidyverse
library(tidyverse)

# basic plot in base R
hist(mtcars$mpg)
hist(mtcars$hp)

# Analyzing by Histogram - one Quantitative variable
hist(mtcars$hp)
mean(mtcars$hp)
median(mtcars$hp)

str(mtcars)
mtcars$am <- factor(mtcars$am,
                    level = c(0,1),
                    labels = c("Auto", "Manual"))

# Bar plot one Qualitative variable
barplot(table(mtcars$am))

# Box plot
boxplot(mtcars$hp)
fivenum(mtcars$hp)

min(mtcars$hp)
quantile(mtcars$hp, probs = c(.25, .5, .75))
median(mtcars$hp)
max(mtcars$hp)

# whisker calculation
Q3 <- quantile(mtcars$hp, c(.75))
Q1 <- quantile(mtcars$hp, c(.25))
IQR_hp <- Q3 - Q1

Q3 + 1.5*IQR_hp
Q1 - 1.5*IQR_hp

boxplot.stats(mtcars$hp, coef = 1.5)

# filter out outliers
mtcars_no_out <- mtcars %>%
  filter(hp < 335)

boxplot(mtcars_no_out$hp)

# Boxplot 2 variable
# Quantitative x Qualitative
data(mtcars)
mtcars$am <- factor(mtcars$am,
                    level = c(0,1),
                    labels = c("Auto", "Manual"))

boxplot(mpg ~ am, data = mtcars, 
        col = c("gold", "salmon"))

# Scatter plot
# Quantitative
plot(mtcars$hp, mtcars$mpg, pch = 16,
     col = "salmon",
     main = "Relationship between HP and MPG",
     xlab = "Horse power",
     ylab = "Miles per Gallon")

cor(mtcars$hp, mtcars$mpg)
lm(mpg ~ hp, data = mtcars)










set.seed(1); rpois(5, 2); # Q1

rnorm(1:100)
?rnorm
?dnorm
?qnorm

rpois(1:100,100)
help.search("distribution")



set.seed(10)
x <- rbinom(10, 10, 0.5); x
e <- rnorm(10, 0, 20); e
y <- 0.5 + 2 * x + e; y

?rbinom

y <- 1:100
x1 <- 1:100
x2 <- 1:100
library(datasets)
?Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)

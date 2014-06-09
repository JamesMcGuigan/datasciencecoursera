library(datasets)
data(iris)
iris
head(iris)

Q1 <- mean(iris$Sepal.Length[iris$Species == "virginica"])
Q1

Q2 <- apply(iris[, 1:4], 2, mean)
Q2


##  How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
library(datasets)
data(mtcars)
?mtcars
?sapply
?tapply
mtcars

split(mtcars, mtcars$cyl)
split(mtcars$mpg, mtcars$cyl)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
mean(mtcars$mpg, mtcars$cyl)
tapply(mtcars$mpg, mtcars$cyl, mean)

Q3 <- sapply(split(mtcars$mpg, mtcars$cyl), mean); Q3

Q4 <- Q3[[1]] - Q3[[3]]; Q4


debug(ls)
ls
?debug


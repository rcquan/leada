#Data One
data_one = data.frame(x=c(anscombe$x1), y=c(anscombe$y1))
summary(data_one$x)
summary(data_one$y)

#Data Two
data_two = data.frame(x=c(anscombe$x2), y=c(anscombe$y2))
summary(data_two$x)
summary(data_two$y)

#Data Three
data_three = data.frame(x=c(anscombe$x3), y=c(anscombe$y3))
summary(data_three$x)
summary(data_three$y)

#Data four
data_four = data.frame(x=c(anscombe$x4), y=c(anscombe$y4))
summary(data_four$x)
summary(data_four$y)

#Fitting Linear Models
compare_one <- data_one #change data_one to another dataset
compare_two <- data_two

linear.mod1 = lm(y ~ x, data = compare_one)
linear.mod2 = lm(y ~ x, data = compare_two)

#plotting the linear model
plot(c(0, 10), c(0, 10) , type="n", axes=T, xlab="", ylab="") #we'll start with an empty plot.
abline(linear.mod1, col = 'red', lwd=3) #adding the fitted line for the 1st linear model.
abline(linear.mod2, col='orange', lwd=5) #adding the fitted line for the 2nd linear model.

#Analyze LM Result
plot(compare_one, col='blue', pch=19)
points(compare_two, col='green', pch=19)
abline(linear.mod1, col = 'red', lwd=3)
abline(linear.mod2, col='orange', lwd=5) #regression lines have the same intercept and slope!

#Correct Analyses of Datasets

#(proper) Data One
plot(data_one, col='green', pch=15)
linear_model_one = lm(y ~ x, data = data_one)
abline(linear_model_one, col = 'blue', lwd=3)

#(proper) Data Two
plot(data_two, col = 'blue', pch=15)
quadratic_fit = lm(y ~ x + I(x^2), data = data_two)
quadratic_fit
#generate granular x-values
xvalues <- seq(4,14,0.01)
#calculate predicted y
fitted_yhat <- predict (quadratic_fit, data.frame(x=xvalues))
#add fitted points from original data
points(data_two$x, predict(quadratic_fit), type = "p", col = "red", lwd=3)
lines(x=xvalues, y=fitted_yhat, lwd=2, col="darkgrey")

#(proper) Data Three
plot(data_three, col = "orange", pch = 17, main = "Data Three") #outlier at x=13
boxplot(data_three, main = "Data Three") #boxplot

max(data_three$y) #highest y-value 
cleaned_data_three <- data_three[-3,] #removes outlier from dataset at index 3
cleaned_data_three

plot(cleaned_data_three, col = "orange", pch = 17, main = "Cleaned Data Three")
linear_model_three = lm(y ~ x, data = cleaned_data_three) #fitting a linear model
abline(linear_model_three, col = "blue", lwd =3)

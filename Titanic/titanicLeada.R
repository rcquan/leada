trainData <- read.csv("train.csv")
testData <- read.csv("test.csv")
head(testData)
head(trainData)

histogram(Survived ~ Sex, data = trainData,
          ylab = "Percent Survival",
          xlab = "Sex",
          main = "Titanic Survival by Sex")

trainData$Child <- ifelse(trainData$Age < 18, "Child", "Adult")
trainData$Child <- as.factor(trainData$Child)

histogram(Survived ~ Child, data = trainData,
          main = "Titanic Survival by Age",
          xlab = "Age (Child < 18yo)",
          ylab = "Percent Survived")


mean <- mean(trainData$Age, na.rm = TRUE)
for (i in 1:length(trainData$Age)){
        if(is.na(trainData$Age[i])){
                trainData$Age[i] <- mean
        }  
}
trainData$Age



testData$Child <- ifelse(testData$Age < 18, "Child", "Adult")
testData$Child <- as.factor(testData$Child)


library(ggplot2)
qplot(Age, data = testData, col = Sex)
qplot(Age, data = trainData, col = Sex)


mean <- mean(testData$Age, na.rm = TRUE)
for (i in 1:length(testData$Age)){
        if(is.na(testData$Age[i])){
                testData$Age[i] <- mean
        }  
}

testData$Fare[153] <- mean(trainData$Fare)

library(caret)
model <- train(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch, 
               data=trainData, method = "rpart")
model
Prediction <- as.character(predict(model, newdata = testData))

PassengerId <- testData$PassengerId
submission <- cbind(PassengerId, Prediction)

write.csv(submission, file = "submission.csv", row.names = FALSE)


TRUE + 1

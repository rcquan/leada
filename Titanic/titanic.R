#Read in Train and Test Data
trainData <- read.csv("train.csv", header = TRUE, stringsAsFactors = FALSE)
testData <- read.csv("test.csv", header = TRUE, stringsAsFactors = FALSE)

head(trainData)
tail(trainData)
trainData

#Visualize Train Data
counts <- table(trainData$Survived, trainData$Sex)
barplot(counts, xlab = "Gender", ylab = "Number of People", main = "Survival by Sex")

#Relative Risk
counts[2] / (counts[1] + counts[2])
counts[4] / (counts[3] + counts[4])

#Clean Train Data (AGE)
trainData$Age
mean_age <- round(mean(trainData$Age, na.rm=T))
for (i in 1:nrow(trainData)){
        if (is.na(trainData[i,6])){
                trainData$Age[i] <- mean_age
        }
}

#Visualize Test Data
plot(density(testData$Age, na.rm = TRUE), main = "Test Data Age Density")
plot(density(trainData$Age, na.rm = TRUE), main = "Train Data Age Density")

#Clean Test Data(AGE)
testData$Age
test_mean_age <- round(mean(testData$Age, na.rm = T))
for (i in 1:nrow(testData)){
        if (is.na(testData[i,5])){
                testData$Age[i] <- test_mean_age
        }
}

#Apply a Classification Tree Model
library('rpart')
tree_model <- rpart(Survived ~ Pclass + Sex + Age, data = trainData, method = "class")
plot(tree_model)
text(tree_model)

test_predictions <- round(predict(tree_model, newdata = testData)[, 2], 0)
model_submission <- cbind(testData$PassengerId, test_predictions)
colnames(model_submission) <- c("PassengerId", "Prediction")
write.csv(model_submission, "mysubmission.csv", row.names = FALSE)

#Create binary variable titled "Child"
trainData["Child"] <- NA
for (i in 1:nrow(trainData)){
        if (trainData$Age[i] <= 18){
                trainData$Child[i] <- 1
        }
        else if (trainData$Age[i] > 18){
                trainData$Child[i] <- 2
        }
}

#Create binary variable "Child"
testData["Child"] <- NA
for (i in 1:nrow(testData)){
        if (testData$Age[i] <= 18){
                testData$Child[i] <- 1
        }
        else if (testData$Age[i] > 18){
                testData$Child[i] <- 2
        }
}

#Add "Child" variable to Classification Tree Model
tree_model <- rpart(Survived ~ Pclass + Child + Sex, data = trainData, method = "class")
plot(tree_model)
text(tree_model)

test_predictions <- round(predict(tree_model, newdata = testData)[, 2], 0)
model_submission <- cbind(testData$PassengerId, test_predictions)
colnames(model_submission) <- c("PassengerId", "Prediction")
write.csv(model_submission, "child.csv", row.names = FALSE)

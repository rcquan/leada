library(randomForest)
train_all <- read.csv("train.csv", header=TRUE, as.is=TRUE )
test_all  <- read.csv("test.csv", header=TRUE,  as.is=TRUE )

# create test and training set with features of interest
train <- data.frame(survived=as.factor(train_all$Survived),
                    age=train_all$Age,
                    sex=as.integer(factor(train_all$Sex)),
                    fare=train_all$Fare,
                    pclass=train_all$Pclass)
test  <- data.frame(age=test_all$Age,
                    sex=as.integer(factor(test_all$Sex)),
                    fare=test_all$Fare,
                    pclass=test_all$Pclass)

# Impute values for NA
train$fare[ is.na( train$fare) ] <- 0
test$fare[ is.na( test$fare) ]   <- 0
test$age[ is.na( test$age) ]     <- median(train$age, na.rm = TRUE)
train$age[ is.na( train$age) ]   <- median(train$age, na.rm = TRUE)


library(caret)
inTrain <- createDataPartition(train$survived, p = 0.7, list = FALSE)
trainData <- train[inTrain,] # training set
validData <- train[-inTrain,] #cross-validation set

# Using Random forests as ensemble learning for classification
modFit <- train(survived ~., data = trainData, method = "rf")

# Estimating out of sample error using cross-validation set
pred <- predict(modFit, validData)
confusionMatrix(Prediction, validData$survived)

# Prediction on test data
Prediction <- predict(modFit, test)
PassengerId <- test_all$PassengerId
submission <- cbind(PassengerId, Prediction)

write.csv(submission, file="submission.csv", row.names = FALSE) 


trainData = read.csv("~/titanic_train.csv", header = TRUE)
testData = read.csv("~/titanic_test.csv", header = TRUE)

trainData$Age[is.na(trainData$Age)] = 29.7
testData$Age[is.na(testData$Age)] = 27
testData$Fare[is.na(testData$Fare)] = 35.627

set.seed(323)

fit = randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare, data=trainData, importance=TRUE, ntree=2000)

results = predict(fit, testData)

passengerId = testData$PassengerId

kaggle_sub = cbind(passengerId, results)
colnames(kaggle_sub) = c("PassengerId", "Survived")
write.csv(kaggle_sub, file = "titanic_kaggle_prediction.csv", row.names = FALSE)

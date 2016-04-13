# First download the train and test files off of kaggle before starting.
# Look at the data in r using the summary command: summary(trainData)
# Need to understand the data in order to clean properly.
# This code does the bare minimum for cleaning and the result is a score of .77512

# Import train file or the data that you will use to build your model
trainData = read.csv("~/titanic_train.csv", header = TRUE)

# Import test file, which you will fit your model to and make predictions for.
testData = read.csv("~/titanic_test.csv", header = TRUE)

# Age variable had missing data, replaced missing data with the median age value
trainData$Age[is.na(trainData$Age)] = 29.7

# Age variable had missing data in test file, replaced missing data with mean age value
testData$Age[is.na(testData$Age)] = 27

# Fare variable had missing data, used mean value
testData$Fare[is.na(testData$Fare)] = 35.627

set.seed(323)

# Create the random forest model
fit = randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare, data=trainData, importance=TRUE, ntree=2000)

# Results will be the predictions made using the model on the test data
results = predict(fit, testData)

# Create variable representing the passenger ID, will be used for submission
passengerId = testData$PassengerId

# Pair up the passenger ID with its result
kaggle_sub = cbind(passengerId, results)

# Create two columns: ID and Survived
colnames(kaggle_sub) = c("PassengerId", "Survived")

# Create a csv file with the results
write.csv(kaggle_sub, file = "titanic_kaggle_prediction.csv", row.names = FALSE)

# May have to go into the csv file and manually change the 2's to 1's and the 1's to 0's for the results.
# I did this in excel using the replacement finder tool.

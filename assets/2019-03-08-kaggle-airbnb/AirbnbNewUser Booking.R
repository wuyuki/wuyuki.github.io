library(ggplot2)
#train dataset
data_train_user <- read.csv(file = "/Users/yuki/Yuki/Local/Kaggle/Airbnb-New User Booking/data/train_users_2.csv")
#head(data_train_user)
dim(data_train_user)
#test dataset
data_test_user <- read.csv(file = "/Users/yuki/Yuki/Local/Kaggle/Airbnb-New User Booking/data/test_users.csv")
#head(data_test_user)
dim(data_test_user)

# Merge train and test dataset
data_test_user$country_destination <- NaN
#head(data_test_user)
data_all_user <- rbind(data_train_user, data_test_user)
dim(data_all_user)
# Delete id column
data_all_user$id <- NULL
# Rearrange columns by column names
data_all_user <- data_all_user[,order(names(data_all_user))]
#head(data_all_user)
dim(data_all_user)

#Replace missing value
data_all_user$gender[data_all_user$gender == "-unknown-"] <- NA
#Calculate the number of missing data
data_NA_proportion <- colSums(is.na(data_all_user)) / dim(data_all_user)[1]
print(data_NA_proportion)
#Summary age
summary(data_all_user$age)
summary(na.omit(data_all_user$age[data_all_user$age > 100]))
summary(na.omit(data_all_user$age[data_all_user$age < 18]))
#Replace age>95 && age < 12 by missing value
data_all_user$age[data_all_user$age > 95] <- NA
data_all_user$age[data_all_user$age < 13] <- NA
summary(data_all_user$age)


#Gender
p <- ggplot(data=data_all_user, aes(x=gender))
p +geom_bar(stat = "count", color="black", fill="white") + xlab("Gender") + ylab("Count")

#Gender & Country
p <- ggplot(data=na.omit(data_all_user), mapping=aes(x=country_destination, fill=gender), na.rm = TRUE)
p +geom_bar(stat = "count", position = "dodge") + xlab("Country") + ylab("Count") + theme_bw()

#Age
p <- ggplot(data=data_all_user,aes(x=age)) 
p + geom_histogram(aes(y=..density..), binwidth = 2, color="black", fill="white") + 
  geom_density(alpha=.2, fill="#FF6666") +
  scale_x_continuous(breaks=seq(0, 100, 5)) 

#Age & Country
data_all_user$age_range <- findInterval(data_all_user$age, c(0,20,40,60,80,100))
data_all_user$age_range <- as.factor(data_all_user$age_range)
p <- ggplot(data=na.omit(data_all_user), mapping=aes(x=country_destination, fill=age_range), na.rm=TRUE)
p +geom_bar(stat = "count", position = "dodge") + xlab("Country") + ylab("Count") + theme_bw() + 
  scale_fill_discrete(name="Age", breaks=c("1", "2", "3", "4", "5"), labels=c("0-20", "20-40", "40-60", "60-80", "80-100"))

#Date & Account
data_all_user$date_account_created_year=substr(data_all_user$date_account_created,1,4)
data_all_user$date_account_created_weekday=weekdays(as.Date(data_all_user$date_account_created))
p <- ggplot(data=data_all_user, mapping=aes(x=date_account_created_year))
p + geom_bar(stat="count", color="black", fill="white") + xlab("Year") + ylab("Count")
p <- ggplot(data=data_all_user, mapping=aes(x=date_account_created_weekday))
p + geom_bar(stat="count", color="black", fill="white") + xlab("Weekday") + ylab("Count")

#Platform
p <- ggplot(data=na.omit(data_all_user), mapping=aes(x=signup_app, fill=country_destination), na.rm = TRUE)
p +geom_bar(stat = "count") + xlab("Platform") + ylab("Count") + theme_bw()

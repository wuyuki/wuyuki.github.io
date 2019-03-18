---
layout: post
title:  "Airbnb New User Booking"
date:   2019-03-08 20:00:00
categories: data-analysis
keywords: data visualization, data-analysis
relatedwords: kaggle
---

[数据](\assets\2019-03-08-kaggle-airbnb\data.zip)来源: Airbnb

#### Data Exploration

1. Exam datasets
{% highlight r %} 
#train dataset
data_train_user <- read.csv(file = "C:\\Users\\yuki\\Desktop\\airbnb-recruiting-new-user-bookings\\train_users_2.csv")
head(data_train_user)
dim(data_train_user)
#test dataset
data_test_user <- read.csv(file = "C:\\Users\\yuki\\Desktop\\airbnb-recruiting-new-user-bookings\\test_users.csv")
head(data_test_user)
dim(data_test_user)
{% endhighlight %}

2. Rearrange datasets
{% highlight r %} 
# Merge train and test dataset
data_test_user$country_destination <- NaN
head(data_test_user)
data_all_user <- rbind(data_train_user, data_test_user)
dim(data_all_user)
# Delete id column
data_all_user$id <- NULL
head(data_all_user)
{% endhighlight %}
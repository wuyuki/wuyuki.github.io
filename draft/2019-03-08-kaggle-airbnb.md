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

通常在开始一项数据分析项目之前，我会思考：
* 这份数据是否是正确的？
* 这份数据是否有异常部分，例如某段时间的异常波动等？
* 这份数据是否需要增加或者删除部分数据使其更符合现实？

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
data_test_user$country_destination <- NA
head(data_test_user)
data_all_user <- rbind(data_train_user, data_test_user)
dim(data_all_user)
# Delete id column
data_all_user$id <- NULL
# Rearrange columns by column names...强迫症而已
data_all_user <- data_all_user[,order(names(data_all_user))]
head(data_all_user)
{% endhighlight %}

#### Missing Data

1. 在 R 中缺失值以 NA 表示，但是可以看见 column(gender) 中有 “-unknown-” 的表示，所以要将其重编码为缺失值
{% highlight r %} 
#Replace missing value
data_all_user$gender[data_all_user$gender == "-unknown-"] <- NA
{% endhighlight %}

2. 通过缺失值检查，可以发现年龄与性别的缺失值比例很高
{% highlight r %} 
#Calculate the number of missing data
data_NA_proportion <- colSums(is.na(data_all_user)) / dim(data_all_user)[1]
print(data_NA_proportion)
{% endhighlight %}

3. 检查年龄变量，我们可以发现某一部分用户的年龄是不真实的.当用户年龄大于100时，50%以上的用户年龄大于2014，基本不可靠；当用户年龄小于18时，50%以上的用户年龄大于16，勉强符合实际。因此需要对不可靠的年龄数据进行删除。
{% highlight r %} 
#Replace age>95 && age < 12 by missing value
data_all_user$age[data_all_user$age > 95] <- NA
data_all_user$age[data_all_user$age < 13] <- NA
summary(data_all_user$age)
{% endhighlight %}

#### Data Visulization

通常，只看数据的均值，中位数，分位数等基础统计量对于进一步了解数据并没有太大的帮助，除非你十分清除你的数据集合。

将数据绘制成可视化图形更有利于我们观察到数据的异常值和错误值。我们可以逐个变量进行探索。

1. Gender

分析可见，不同性别对于选择旅行目的地并没有明显的区别。但是大部分新用户预定的目的地在美国。

![Gender](\assets\2019-03-08-kaggle-airbnb\Gender.png)

![Gender&Country](\assets\2019-03-08-kaggle-airbnb\Gender_Country.png)

{% highlight r %} 
count_gender <- table(data_all_user$gender[,drop=T])
count_gender <- as.data.frame(count_gender)
p <- ggplot(data=count_gender, aes(x=Var1, y=Freq))
p +geom_bar(stat = "identity") + xlab("Gender") + ylab("Count")
#Gender & Country
count_country <- table(data_all_user$gender[,drop=T], data_all_user$country_destination)
count_country <- as.data.frame(count_country)
p <- ggplot(data=count_country, aes(x=Var2, y=Freq))
p +geom_bar(stat = "identity", aes(fill=Var1), position = "dodge") + xlab("Country") + ylab("Count") + theme_bw()
{% endhighlight %}

2. Age

分析可见，
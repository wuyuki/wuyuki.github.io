---
layout: post
title:  "Airbnb New User Booking - Part 1"
date:   2019-03-08 20:00:00
categories: data-analysis
keywords: data visualization, data-analysis
relatedwords: kaggle
---

### Background
<hr/>

[数据](\assets\2019-03-08-kaggle-airbnb\data.zip)来源: [Airbnb](https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings)

情景：预测新用户的预定目的地，给与新用户合适的消息推送。

### Data Exploration
<hr/>

通常在开始一项数据分析项目之前，我会思考：
<blockquote>
* 这份数据是否是正确的？
<br/>
* 这份数据是否有异常部分，例如某段时间的异常波动等？
<br/>
* 这份数据是否需要增加或者删除部分数据使其更符合现实？
</blockquote>

#### Exam datasets
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

#### Rearrange datasets
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

* 在 R 中缺失值以 NA 表示，但是可以看见 column(gender) 中有 “-unknown-” 的表示，所以要将其重编码为缺失值

{% highlight r %} 
#Replace missing value
data_all_user$gender[data_all_user$gender == "-unknown-"] <- NA
{% endhighlight %}

* 通过缺失值检查，可以发现年龄与性别的缺失值比例很高

{% highlight r %} 
#Calculate the number of missing data
data_NA_proportion <- colSums(is.na(data_all_user)) / dim(data_all_user)[1]
print(data_NA_proportion)
{% endhighlight %}

* 检查年龄变量，我们可以发现某一部分用户的年龄是不真实的.当用户年龄大于100时，50%以上的用户年龄大于2014，基本不可靠；当用户年龄小于18时，50%以上的用户年龄大于16，勉强符合实际。因此需要对不可靠的年龄数据进行删除。

{% highlight r %} 
#Replace age>95 && age < 12 by missing value
data_all_user$age[data_all_user$age > 95] <- NA
data_all_user$age[data_all_user$age < 13] <- NA
summary(data_all_user$age)
{% endhighlight %}


### Data Visulization
<hr/>

通常，只看数据的均值，中位数，分位数等基础统计量对于进一步了解数据并没有太大的帮助，除非你十分清除你的数据集合。

将数据绘制成可视化图形更有利于我们观察到数据的异常值和错误值。我们可以逐个变量进行探索。

#### Gender

分析可见，不同性别对于选择旅行目的地并没有明显的区别。但是大部分新用户预定的目的地在美国。

![Gender](\assets\2019-03-08-kaggle-airbnb\Gender.png)

![Gender&Country](\assets\2019-03-08-kaggle-airbnb\Gender_Country.png)

{% highlight r %} 
#Gender
p <- ggplot(data=data_all_user, aes(x=gender))
p +geom_bar(stat = "count", color="black", fill="white") + xlab("Gender") + ylab("Count")

#Gender & Country
p <- ggplot(data=na.omit(data_all_user), mapping=aes(x=country_destination, fill=gender), na.rm = TRUE)
p +geom_bar(stat = "count", position = "dodge") + xlab("Country") + ylab("Count") + theme_bw()
{% endhighlight %}

#### Age

分析可见，出游用户大多集中在20-45岁, 而且各年龄段的用户选择旅游目的地的差异并不大。
![Age](\assets\2019-03-08-kaggle-airbnb\Age.png)

![Age&Country](\assets\2019-03-08-kaggle-airbnb\Age_Country.png)

{% highlight r %} 
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
{% endhighlight %}

#### Date

分析用户创建账户的时间，可发现在2012-2014年间Airbnb的用户快速的增长而且用户创建账户的时间以周中为主（即周二，周三，周四）。
![Year](\assets\2019-03-08-kaggle-airbnb\Year.png)

![Weekday](\assets\2019-03-08-kaggle-airbnb\Day.png)

{% highlight r %} 
#Date & Account
data_all_user$date_account_created_year=substr(data_all_user$date_account_created,1,4)
data_all_user$date_account_created_weekday=weekdays(as.Date(data_all_user$date_account_created))
p <- ggplot(data=data_all_user, mapping=aes(x=date_account_created_year))
p + geom_bar(stat="count", color="black", fill="white") + xlab("Year") + ylab("Count")
p <- ggplot(data=data_all_user, mapping=aes(x=date_account_created_weekday))
p + geom_bar(stat="count", color="black", fill="white") + xlab("Weekday") + ylab("Count")
{% endhighlight %}

#### Platform

目前使用 Web 端下订单的用户还是占大多数，而且使用 Web 端的用户大部分不会在第一次就预定旅行。

![Platform](\assets\2019-03-08-kaggle-airbnb\Platform.png)

{% highlight r %} 
#Platform
p <- ggplot(data=na.omit(data_all_user), mapping=aes(x=signup_app, fill=country_destination), na.rm = TRUE)
p +geom_bar(stat = "count") + xlab("Platform") + ylab("Count") + theme_bw()
{% endhighlight %}

#### To be Continue...


### Sample Code
<hr/>

[download here](\assets\2019-02-28-word-cloud-4\AirbnbNewUserBooking.zip)

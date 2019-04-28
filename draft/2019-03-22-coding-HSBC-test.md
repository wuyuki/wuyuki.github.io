---
layout: post
title:  "一次 R 的小测验"
date:   2019-03-22 20:00:00
categories: miscellaneous
keywords: R, text mining
relatedwords: coding
---

一紧张就胃疼，一胃疼就脑袋空白……

还有 R Studio 的 Help command 和自动补全太强大，然后离开他们就不会手写 Script。

全程懊恼悲伤……

但是还是要懂得从失败和错误中学习。

复盘！
<br/>

#### Question1
<hr/>

计算字符串中（例如 f=“12adb67acbdgd”）含有 “a?b” 的个数 （如例子结果为2）。

{% highlight r %} 
# input string
print('Please enter the strin here：')
text <- readline()
# search match items
result_list <- gregexpr("a*b", text)
result <- length(count[[1]])
#output result
print(result)
{% endhighlight %}
<br/>

#### Question2
<hr/>

计算某用户所在的组的另一性别的用户的分数。

| Team |-| Gender |-| Score |
|------|-|--------|-|-------|
|  1   | |  Male  | |  81   | 
|  2   | | Female | |  65   |
|  2   | | Female | |  78   |
|  1   | | Female | |  92   |
|  2   | | Male   | |  85   |

{% highlight r %} 
# build the data frame
team <- c("team1", "team2", "team2", "team1", "team2")
gender <- c("male", "female", "female", "female", "male")
score <- c(81, 65, 78, 92, 85)
data_user <- data.frame(team, gender, score)
data_user
# collect input value
print('Please enter the team name：')
team=readline()
print('Please enter the gender：')
gender=readline()
# select value in data frame
result <- data_user$score[data_user$team == team & data_user$gender != gender]
# output result
print(result)
{% endhighlight %}
<br/>

#### 反省
<hr/>

1. 就算记不清函数的名字和用法，也至少要写下自己的思路。
2. 记不清 R 的函数名，可以尝试自己更熟悉的语言，例如用 C 或 C++ 写。
3. 以后要知其然也要努力的知其所以然，减少编译器工具的依赖。

好了，我去面壁手写 code 10 次。呜呜呜呜……
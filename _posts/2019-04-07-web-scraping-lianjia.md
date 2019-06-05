---
layout: post
title:  "爬取链家网广州二手房数据"
date:   2019-03-17 20:00:00
categories: R
keywords: web scraping, rvest, data-analysis
relatedwords: web scraping
---

之前在博客分享了利用 R 和 rvest 包爬虫的基础方法。现在就来实战一下：爬取链家网广州 40,000+ 套二手房的数据。
![lianjia homepage](\assets\2019-04-07-web-scraping-lianjia\lianjia homepage.png)

之前在 [Web Scraping with R](https://wuyuki.github.io/r/2019/03/17/web-scraping.html) 说过的爬虫方法在这篇中就不在赘述了。这里就分享怎么样爬取网站中翻页的数据。

### Web Scraping across Multiple Pages
<hr/>

首先观察翻页页面的 url 规律，比如广州链家二手房数据：

第一页：https://gz.lianjia.com/ershoufang/

第二页：https://gz.lianjia.com/ershoufang/pg2/

第三页：https://gz.lianjia.com/ershoufang/pg3/

......

由此可推断，url 为 "https://gz.lianjia.com/ershoufang/pg" + 页码

1. 假设我们需要爬去第 1 页到第 100 页的房屋总价。那么我们可以先尝试爬取第一页的数据，并封装成一个函数.

{% highlight r %} 
getHouseInfo <- function(pageNum, urlWithoutPageNum) {
  url <- paste0(urlWithoutPageNum, pageNum)
  webpage <- read_html(url,encoding="UTF-8")
  total_price_data_html <- html_nodes(webpage,'.totalPrice span')
  total_price_data <- html_text(total_price_data_html)
  data.frame(totalprice = total_price_data)
}
{% endhighlight %}

2. 然后利用上述的函数循环爬取第 1 页到第 100 页的数据，并将多页的数据合并成一个 data frame

{% highlight r %} 
url <- "https://gz.lianjia.com/ershoufang/pg"
houseInfo <- data.frame()
for (ii in 1:1553){
  houseInfo <- rbind(houseInfo, getHouseInfo(ii, url))
}
{% endhighlight %}

### Sample Code
<hr/>

知道如何爬取翻页的数据后我们就可以尝试完整的爬取广州链家网上 4w+ 套二手房的详细信息（包括区域，小区，几室几厅，有无电梯等等）了。

[download here](\assets\2019-04-07-web-scraping-lianjia\houses.zip)

数据量比较大，爬取数据需要一些时间。爬取完毕如果要保存数据需要注意选择适合的编码，不然容易乱码。提供一个可在 Mac Excel 打开的 cvs 格式。

[data](\assets\2019-04-07-web-scraping-lianjia\data in mac.zip)
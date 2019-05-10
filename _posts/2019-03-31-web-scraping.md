---
layout: post
title:  "Web Scraping with R"
date:   2019-03-31 20:00:00
categories: R
keywords: web scraping, rvest, data-analysis
relatedwords: web scraping
---

网络上有大量的信息与数据。我们可以利用爬虫技术来获取这些巨大的数据资源。

这次用 IMDb 网站的[2018年100部最欢迎的电影](https://www.imdb.com/search/title?count=100&release_date=2018-01-01,2018-12-31&view=advanced) 来练练手，顺便总结一下 R 爬虫的方法。

### Preparation
<hr/>

感谢 Hadley Wickham 大大，我们有 ```rvest``` 包可以用。因此爬虫前先安装并加载 ```revest``` 包。

{% highlight r %} 
#install package
install.package('rvest')
#loading library
library('rvest')
{% endhighlight %}

### Downloading and parsing HTML file
<hr/>

指定网页地址并且使用 ```read_html()``` 函数将网页转为 XML 对象。

{% highlight r %} 
url <- 'https://www.imdb.com/search/title?count=100&release_date=2018-01-01,2018-12-31&view=advanced'
webpage <- read_html(url)
{% endhighlight %}

### Extracting Nodes
<hr/>

我期望获取的数据包括：
1. **Rank**: 排名
2. **Title**：电影名称
3. **Runtime**：电影时长
4. **Genre**：电影类型
5. **Rating**：观众评分
6. **Metascore**：媒体评分
7. **Description**：电影简介
8. **Votes**：观众投票支持的票数
9. **Gross**：电影票房

![IDMb Movie](\assets\2019-03-31-web-scraping-with-R\IDMb Movie.png)

使用 ```html_nodes()``` 函数可以提取 XML 对象中的元素。其中该函数利用 CSS 选择器来匹配吻合的元素。

{% highlight r %} 
#Using CSS selectors to extract node
rank_data_html <- html_nodes(webpage, '.text-primary')
#Converting the node to text
rank_data <- html_text(rank_data_html)
#Converting text value to numeric value
rank_data <- as.numeric(rank_data)
{% endhighlight %}

因为需要利用 [CSS 选择器](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)， 所以这个部分或许需要一点 HTML/CSS 的基础知识。如果不熟悉 HTML/CSS，分享一个小方法：
1. 用浏览器（以 Chrome 为例）打开那个网页，然后按 F12 打开开发者工具
2. 点击开发者工具左上角的箭头去选择那个需要爬取的数据
3. 对应的那行代码就会在右侧的开发者工具被选中
4. 对着 CSS 选择器的文档查查就知道该怎么写了

![IDMb Webpage](\assets\2019-03-31-web-scraping-with-R\IDMb Webpage.png)

接着用类似的 Script 提取其他元素的数据。 

### Handling Missing Values
<hr/>

爬取元素后，如果仔细检查每组元素的长度，就会发现其实某些元素是有缺失值的。比如说 Metascore

{% highlight r %} 
metascore_data_html <- html_nodes(webpage,'.metascore')
metascore_data <- html_text(metascore_data_html)
length(metascore_data)
{% endhighlight %}

怎么将网页中不存在的相应值用 NA 表示呢？

这里要了解一下 ```html_node``` 和 ```html_nodes``` 的区别了。运行 ```?html_node``` 查看帮助文档： 

<blockquote>
html_node is like [[ it always extracts exactly one element. When given a list of nodes, html_node will always return a list of the same length, the length of html_nodes might be longer or shorter.
</blockquote>

所以简单地说，就是我们可以先提取一组没有缺失值的父级 DOM，然后从这组 DOM 中逐个提取所需的子级 DOM。

粗暴地说，上代码：

{% highlight r %} 
metascore_data_html <- html_node(html_nodes(webpage, '.lister-item-content'), '.metascore')
metascore_data <- html_text(metascore_data_html)
length(metascore_data)
{% endhighlight %}

### Making a Data Frame
<hr/>

等所有数据都爬取完毕，就可以将其组合成 data frame 用于后续的分析了。

{% highlight r %} 
movies <- data.frame(
  rank = rank_data,
  title = title_data,
  description = description_data,
  runtime = runtime_data,
  genre = genre_data,
  rating = rating_data,
  metascorre = metascore_data,
  votes = votes_data,
  gross = gross_data
)
{% endhighlight %}

### Exporting CSV File
<hr/>

如果不想马上开始分析工作，还可以存为 csv 文件以后用。

{% highlight r %} 
write.csv(movies, file = file.choose(new = TRUE), row.names = FALSE)
{% endhighlight %}

搞定爬虫后，现在网络上已经有很多数据资源等我们用咯。

### Notes
<hr/>

```rvest``` 包还有其他有用的函数可以发掘一下的：

1. ```html_tag()```: 提取DOM 的 tag name
2. ```html_attr()```: 提取DOM 的 一个属性
3. ```html_attrs()```: 提取DOM 的 所有属性
4. ```guess_encoding()``` and ```repair_encoding()```： 检测编码和修复编码 （爬取中文网页的时候会用的到的~）
5. ```jump_to()```, ```follow_link()```, ``````back()``````, ```forward()```: 爬取多页面网页的时候或许会用到

### Sample Code
<hr/>

[download here](\assets\2019-03-31-web-scraping-with-R\Web Scraping with R_IMDb.zip)








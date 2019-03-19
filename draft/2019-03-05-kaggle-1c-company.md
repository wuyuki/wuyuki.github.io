---
layout: post
title:  "1C Company Predict Future Salse"
date:   2019-03-05 20:00:00
categories: data-analysis
keywords: data visualization, data-analysis
relatedwords: kaggle
---

[数据](\assets\2019-03-05-kaggle-1c-compamy\data.zip)来源: Russian 1C Company

#### Data Files

|       File      |    |     Description     |
| --------------- | -- |-------------------- |
| sales_train.csv |    |Daily historical data|
| items.csv	      |    |Supplemental information about the items/products|

#### Outlooks

1. 数据探索：了解数据的维度，行，列，列名称，数据类型等等
2. 数据清洗
	1. 缺失值处理：通过判断缺失值对数据观察，绘图以及建模时的可能产生的影响，从而决定是否填充或者删除缺失值
	2. 分类值处理：了解该分类下不同值所代表的含义，如 0 = male， 1 = female
	3. 数据类型转换：根据模型需求将：1）用 dummy variable（0/1）将 categorical value 转换为 numeric value；或者 2）用 factor variable 将 numeric value 转换为 categorical value
3. 数据统计
	1. 检查数据头尾部，看看数据是否加载完整
	2. 描述性统计：利用 mean， median， mode等统计量对数据进行简单地观察
	3. 了解各变量（各列值）相互之间的影响：1）Correlation for numerical data; 2) Chi-Square for categorical data
	4. 特征工程：利用原始数据生成具有统计意义的特征数据
4. 建模：尽可能应用各种建模算法，以查看哪一种算法提供了最佳预测

#### 准备
使用 R 作为数据分析工具，首先安装 ```install.packages()``` 并加载所需的 R 包。

{% highlight r %} 
#loading libraries
library(readr)
library(data.table)
library(datasets)
library(dplyr)
library(lubridate)
library(ggplot2)
library(ggthemes)
library(plotly)
library(Amelia)
library(caTools)
library(class)
library(scales)
{% endhighlight %}

#### 数据探索

读取并初步了解数据。

{% highlight r %} 
#reading datasets
datasets_salse_train <- read.csv("/Users/yuki/Yuki/Local/Kaggle/Predict Future Salse/data/sales_train.csv")
head(datasets_salse_train)
dim(datasets_salse_train)

datasets_item <- read.csv("/Users/yuki/Yuki/Local/Kaggle/Predict Future Salse/data/items.csv")
head(datasets_item)
dim(datasets_item)
{% endhighlight %}
---
layout: post
title:  "How to Compare Means (均值比较)"
date:   2019-03-03 20:00:00
categories: data-analysis
keywords: data-analysis, statistics, t-Test, ANOVA, mean, variance, proportion
relatedwords: statistics
---

在比较数据的均值时，我们可能知道：
1. 比较工厂当天生产的零件的长度是否合格 (length >= N mm)，用 t-Test;
2. 比较各一线城市的人均收入，用 ANOVA。

那么比较均值时在选择检验方法有什么规律呢？花了点时间总结了一下：

1. 比较均值
	1. 数据是否符合正态分布？
		1. 是
			1. 数据有多少分组？
				1. 没有分组
					* One-Sample t-Test
					* One-Sample Equivalence Test
				2. 单组双水平
					1.  每个受试者是否进行过两次重复实验?
						1. 是
							* Pair-Sample t-Test
							* Pair-Sample Equivalence Test
							* Hotelling's T-squared Test
						2. 否
							* Two-Sample t-Test
							* Two-Sample Equivalence Test
							* Hotelling's T-squared Test
				3. 单组多水平
					1. 每个受试者是否进行过多次重复实验？
						1. 是
							* One-Way Repeated Measures ANOVA
						2. 否
							* One-Way ANOVA		
				4. 两个分组
					1. 每个受试者是否进行过多次重复实验？
						1. 是
							* Two-Way Repeated Measures ANOVA
						2. 否
							* Two-Way ANOVA
				5. 三个分组
					1. 每个受试者是否进行过多次重复实验？
						1. 是
							* Three-Way Repeated Measures ANOVA
						2. 否
							* Three-Way ANOVA
				6. 任意数量的组
					* General Linear Regression
		2. 否
			1. 数据有多少分组？
				1. 没有分组
					* One-Sample Wilcoxon Signed Rank Test
				2. 单组双水平
					1.  每个受试者是否进行过两次重复实验?
						1. 是
							* Paired-Sample Sign Test
							* Paired-Sample Wilcoxon Signed Rank Test
							* (NPH) Paired Samples
						2. 否
							* Two-Sample Kolmogorov-Smirnov Test
							* Mann-Whitney Test
							* (NPH) Two Independent Samples
							* Cochran's Q Test
				3. 单组多水平
					1. 每个受试者是否进行过多次重复实验？
						1. 是
							* Friedman ANOVA
						2. 否
							* Kruskal-Wallis ANOVA
							* Mood's Median Test
							* (NPH) K Independent Samples
							* Cochran's Q Test
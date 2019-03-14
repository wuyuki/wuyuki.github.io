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

其实均值比较还有很多检验方法，要怎么选？脑阔疼！

今天终于花了点时间自己总结了一下：
<hr/>

* Q1: 数据是否符合正态分布？

	* Q1-A1 是

		* Q2: 数据有多少分组？

			* Q1-A1-Q2-A1 没有分组
				* One-Sample t-Test
				* One-Sample Equivalence Test

			* Q1-A1-Q2-A2 单组双水平

				* Q3: 每个受试者是否进行过两次重复实验?

					* Q1-A1-Q2-A2-Q3-A1 是
						* Pair-Sample t-Test
						* Pair-Sample Equivalence Test
						* Hotelling's T-squared Test

					* Q1-A1-Q2-A2-Q3-A2 否
						* Two-Sample t-Test
						* Two-Sample Equivalence Test
						* Hotelling's T-squared Test

			* Q1-A1-Q2-A3 单组多水平

				* Q4: 每个受试者是否进行过多次重复实验？

					* Q1-A1-Q2-A3-Q4-A1 是
						* One-Way Repeated Measures ANOVA

					* Q1-A1-Q2-A3-Q4-A2 否
						* One-Way ANOVA	

			* Q1-A1-Q2-A4 两个分组

				* Q5: 每个受试者是否进行过多次重复实验？

					* Q1-A1-Q2-A4-Q5-A1 是
						* Two-Way Repeated Measures ANOVA

					* Q1-A1-Q2-A4-Q5-A2 否
						* Two-Way ANOVA

			* Q1-A1-Q2-A5  三个分组

				* Q6: 每个受试者是否进行过多次重复实验？

					* Q1-A1-Q2-A5-Q6-A1  是
						* Three-Way Repeated Measures ANOVA

					* Q1-A1-Q2-A5-Q6-A2 否
						* Three-Way ANOVA
						
			* Q1-A1-Q2-A6 任意数量的组
				* General Linear Regression
	
	* Q1-A2 否

		* Q7: 数据有多少分组？

			* Q1-A2-Q7-A1 没有分组
				* One-Sample Wilcoxon Signed Rank Test

			* Q1-A2-Q7-A2 单组双水平

				* Q8: 每个受试者是否进行过两次重复实验?

					* Q1-A2-Q7-A2-Q8-A1 是
						* Paired-Sample Sign Test
						* Paired-Sample Wilcoxon Signed Rank Test
						* (NPH) Paired Samples

					* Q1-A2-Q7-A2-Q8-A2 否
						* Two-Sample Kolmogorov-Smirnov Test
						* Mann-Whitney Test
						* (NPH) Two Independent Samples
						* Cochran's Q Test

			* Q1-A2-Q7-A3 单组多水平

				* Q9: 每个受试者是否进行过多次重复实验？

					* Q1-A2-Q7-A2-Q9-A1 是
						* Friedman ANOVA

					* Q1-A2-Q7-A2-Q9-A2 否
						* Kruskal-Wallis ANOVA
						* Mood's Median Test
						* (NPH) K Independent Samples
						* Cochran's Q Test
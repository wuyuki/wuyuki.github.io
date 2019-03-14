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

<strong>Q1: 数据是否符合正态分布</strong>
<br/>
<blockquote>
	<strong>Q1-A1 是</strong>
	<br/>
	<blockquote>
	<strong>Q2: 数据有多少分组</strong>
	<br/>
	<blockquote>
		<strong>Q1-A1-Q2-A1 没有分组</strong>
		<blockquote>	
			* One-Sample t-Test
			<br/>
			* One-Sample Equivalence Test
		</blockquote>
		<br/>
		<strong>Q1-A1-Q2-A2 单组双水平</strong>
		<br/>
		<blockquote>
		Q3: 每个受试者是否进行过两次重复实验?
		<br/>
		<blockquote>
			Q1-A1-Q2-A2-Q3-A1 是
			<br/>
			<blockquote>
				* Pair-Sample t-Test
				<br/>
				* Pair-Sample Equivalence Test
				<br/>
				* Hotelling's T-squared Test
				<br/>
			</blockquote>
			<br/>
			* Q1-A1-Q2-A2-Q3-A2 否
			<br/>
			<blockquote>
				* Two-Sample t-Test
				<br/>
				* Two-Sample Equivalence Test
				<br/>
				* Hotelling's T-squared Test
			</blockquote>
		</blockquote>
		</blockquote>
		<br/>
		<strong>Q1-A1-Q2-A3 单组多水平</strong>
		<br/>
		<blockquote>
			* Q4: 每个受试者是否进行过多次重复实验？
			<br/>
			<blockquote>
				* Q1-A1-Q2-A3-Q4-A1 是
			<blockquote>	
					* One-Way Repeated Measures ANOVA
			</blockquote>
			<br/>
				* Q1-A1-Q2-A3-Q4-A2 否
			<blockquote>
					* One-Way ANOVA	
			</blockquote>
			</blockquote>
		</blockquote>
		<br/>
		<strong>Q1-A1-Q2-A4 两个分组</strong>
		<br/>
		<blockquote>
			* Q5: 每个受试者是否进行过多次重复实验？
			<br/>
			<blockquote>
				* Q1-A1-Q2-A4-Q5-A1 是
				<blockquote>
					* Two-Way Repeated Measures ANOVA
				</blockquote>
				<br/>
				* Q1-A1-Q2-A4-Q5-A2 否
				<blockquote>
					* Two-Way ANOVA
				</blockquote>
			</blockquote>
		</blockquote>
		<br/>
		<strong>Q1-A1-Q2-A5  三个分组</strong>
		<blockquote>
			* Q6: 每个受试者是否进行过多次重复实验？
			<br/>
			<blockquote>
				* Q1-A1-Q2-A5-Q6-A1  是
				<blockquote>
					* Three-Way Repeated Measures ANOVA
				</blockquote>
				<br/>
				* Q1-A1-Q2-A5-Q6-A2 否
				<blockquote>
					* Three-Way ANOVA
				</blockquote>
			</blockquote>
		</blockquote>
		<br/>	
		<strong>Q1-A1-Q2-A6 任意数量的组</strong>
		<blockquote>
			* General Linear Regression
		</blockquote>
	</blockquote>
	</blockquote>
</blockquote>
<br/>
<blockquote>
	<strong>Q1-A2 否</strong>
	<br/>
	<blockquote>
		<strong>Q7: 数据有多少分组？</strong>
		<br/>
		<blockquote>
			<strong>Q1-A2-Q7-A1 没有分组</strong>
			<br/>
			<blockquote>
				* One-Sample Wilcoxon Signed Rank Test
			</blockquote>
			<br/>
			<strong>Q1-A2-Q7-A2 单组双水平</strong>
			<br/>
			<blockquote>
				* Q8: 每个受试者是否进行过两次重复实验?
				<br/>
				<blockquote>
					* Q1-A2-Q7-A2-Q8-A1 是
					<blockquote>
						* Paired-Sample Sign Test
						<br/>
						* Paired-Sample Wilcoxon Signed Rank Test
						<br/>
						* (NPH) Paired Samples
					</blockquote>
					<br/>
					* Q1-A2-Q7-A2-Q8-A2 否
					<blockquote>
						* Two-Sample Kolmogorov-Smirnov Test
						<br/>
						* Mann-Whitney Test
						<br/>
						* (NPH) Two Independent Samples
						<br/>
						* Cochran's Q Test
					</blockquote>
				</blockquote>
			</blockquote>
			<br/>
			<strong>Q1-A2-Q7-A3 单组多水平</strong>
			<br/>
			<blockquote>
				* Q9: 每个受试者是否进行过多次重复实验？
				<br/>
				<blockquote>
					* Q1-A2-Q7-A2-Q9-A1 是
					<blockquote>
						* Friedman ANOVA
					</blockquote>
					<br/>
					* Q1-A2-Q7-A2-Q9-A2 否
					<blockquote>
						* Kruskal-Wallis ANOVA
						<br/>
						* Mood's Median Test
						<br/>
						* (NPH) K Independent Samples
						<br/>
						* Cochran's Q Test
					</blockquote>
				</blockquote>
			</blockquote>
	</blockquote>
	</blockquote>
</blockquote>
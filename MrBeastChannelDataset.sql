/*

Mr Beast Channel Statistics and data

Skills used: Data cleaning, CTEs, Self Join, Window function, Creating Views

*/

-- Data Cleaning & Preparation
EXEC sp_rename 'Mr_Beast_data.publishe_date', 'published_date', 'COLUMN';

SELECT *
FROM MrBeastPortfolio..Mr_Beast_data
ORDER BY status, published_date;

-- Breaking down videos uploaded per year and the avg_view_ct

SELECT YEAR(published_date) AS year, COUNT(title) AS videos, AVG(views) AS avg_view_ct
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY YEAR(published_date)
ORDER BY year;

-- Breaking down view count, likes, comments based on if the video is a short or a video
SELECT 
	status, 
	COUNT(title) AS videos, 
	SUM(views) AS total_views, 
	SUM(likes) AS total_likes, 
	SUM(comments) AS total_comments
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY status;

-- Using CTE to calculate the avg_views_per_video based on the status. This will help determine which type of status to focus on
WITH VideoData AS (
SELECT 
	status, 
	COUNT(title) AS videos, 
	SUM(views) AS total_views, 
	SUM(likes) AS total_likes, 
	SUM(comments) AS total_comments
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY status
)
SELECT
	status,
	videos,
	total_views,
	(total_views/videos) AS avg_views_per_video
FROM VideoData;

-- Using basic aggregate functions to break down avg_audience_participation per video

SELECT 
	status, 
	COUNT(title) AS videos, 
	(SUM(views) + SUM(likes) + SUM(comments)) AS total_audience_participation,
	((SUM(views) + SUM(likes) + SUM(comments))/ COUNT(title)) AS avg_participation_per_video
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY status;

--Breaking down the Video's performance through Bins of 5 years
SELECT
	(YEAR(published_date)/5)*5 AS StartYrOf5yrPeriod,
	COUNT(*) AS videos,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes,
	SUM(comments) AS total_comments,
	(SUM(views) + SUM(likes) + SUM(comments)) AS total_audience_participation
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY (YEAR(published_date)/5)*5
ORDER BY StartYrOf5yrPeriod;


-- Using CTE to summarize Yearly Data on the total view count and the Year over year growth
WITH YearlyViews AS (
	SELECT YEAR(published_date) AS year, SUM(views) AS total_view_ct 
	FROM MrBeastPortfolio..Mr_Beast_data
	GROUP BY YEAR(published_date)
)

SELECT * -- This was to test if the CTE worked
FROM YearlyViews
ORDER BY year;

-- Method 1 LAG() for Year over year growth
WITH YearlyViews AS (
SELECT
	YEAR(published_date) AS year, -- Using YEAR() to extra the year from the published_date
	COUNT(title) AS videos, -- Using COUNT() to count the # of videos published
	SUM(views) AS total_view_ct -- Using SUM() to total the views for those videos
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY DATEPART(year, published_date)
)
SELECT
	Year,
	total_view_ct AS Current_year_views,
	LAG(total_view_ct, 1) OVER (ORDER BY year) AS Previous_year_views, -- Getting the previous year's views
	ROUND(
	((total_view_ct - LAG(total_view_ct, 1) OVER (ORDER BY year))/LAG(total_view_ct, 1) OVER (ORDER BY year))*100, 2
	) AS YoyGrowthPercentage
FROM YearlyViews
ORDER BY year;

-- Method 2 Self-join for Year over year growth
WITH YearlyViews AS (
SELECT
	YEAR(published_date) AS year,
	SUM(views) AS total_view_ct
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY YEAR(published_date)
)
SELECT
	cur.year AS CurrentYear,
	cur.total_view_ct AS CurrentYearViewCt,
	pre.total_view_ct AS PreviousYearViewCt,
	ROUND(((cur.total_view_ct - pre.total_view_ct)/pre.total_view_ct)*100, 2) AS YoYGrowthPercentage
FROM YearlyViews AS cur
LEFT JOIN YearlyViews AS pre
	ON cur.year = pre.year + 1
ORDER BY CurrentYear;

CREATE VIEW videos_performance_bins_of_year AS
SELECT
	(YEAR(published_date)/5)*5 AS StartYrOf5yrPeriod,
	COUNT(*) AS videos,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes,
	SUM(comments) AS total_comments,
	(SUM(views) + SUM(likes) + SUM(comments)) AS total_audience_participation
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY (YEAR(published_date)/5)*5;

/*

Queries to use for Tableau

*/

-- Video's KPI
SELECT
	COUNT(*) AS total_videos,
	SUM(views) AS total_views,
	AVG(likes) AS avg_likes_per_vid,
	AVG(comments) AS avg_comments_per_vid,
	AVG(duration_sec / 60) AS avg_video_duration_mins
FROM MrBeastPortfolio..Mr_Beast_data

SELECT
	YEAR(published_date) AS publish_year,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes,
	SUM(comments) AS total_comments
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY YEAR(published_date)
ORDER BY YEAR(published_date)

-- Video Performance
-- top 10 videos based on views
SELECT
	TOP(10) title,
	SUM(views) AS total_views
FROM MrBeastPortfolio..Mr_Beast_data
WHERE status = 'video'
GROUP BY title
ORDER BY total_views DESC

-- Top 10 shorts based on views
SELECT
	TOP(10) title,
	SUM(views) AS total_views
FROM MrBeastPortfolio..Mr_Beast_data
WHERE status = 'shorts'
GROUP BY title
ORDER BY total_views DESC

-- Bottom 10 videos based on views
SELECT
	TOP(10) title,
	SUM(views) AS total_views
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY title
ORDER BY total_views

-- Views vs Video Duration (mins)
SELECT
    title,
    duration_sec / 60.0 AS duration_minutes,
    views
FROM MrBeastPortfolio..Mr_Beast_data


-- Views vs likes

SELECT
	title,
	views,
	likes
FROM MrBeastPortfolio..Mr_Beast_data

-- Performance by video type

SELECT
	status,
	SUM(views) AS total_views,
	AVG(likes) AS avg_likes,
	AVG(comments) AS avg_comments,
	AVG(duration_sec / 60) AS avg_duration_of_video_mins
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY status

-- Dashboard 3 Engagement and Audience Behavior
SELECT
	title,
	ROUND((likes/views)*100, 2) AS likes_to_view_ratio,
	ROUND((comments/views)*100, 2) AS comment_to_view_ratio,
	ROUND(((likes+comments)/views)*100, 2) AS engagement_by_video
FROM MrBeastPortfolio..Mr_Beast_data

-- Dashboard 4 Upload Strategy and Timing Analysis
-- videos DOW vs videos_published
SELECT
	DATENAME(WEEKDAY, published_date) AS day_of_week,
	COUNT(*) AS videos_published
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY DATENAME(WEEKDAY, published_date)
ORDER BY videos_published DESC

-- Views by Publish day (DOW performance)

SET DATEFIRST 1; -- Monday = 1

SELECT
	DATEPART(WEEKDAY, published_date) AS dow_num,
	DATENAME(WEEKDAY, published_date) AS publish_day,
	COUNT(*) AS videos_published,
	ROUND(AVG(views),0) AS avg_views,
	SUM(views) AS total_views
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY
	DATEPART(WEEKDAY, published_date),
	DATENAME(WEEKDAY, published_date)
ORDER BY dow_num

-- Upload Frequency vs AVG views

SELECT
	YEAR(published_date) AS publish_year,
	MONTH(published_date) AS publish_month,
	COUNT(*) AS videos_uploaded,
	ROUND(AVG(views),0) AS avg_views
FROM MrBeastPortfolio..Mr_Beast_data
GROUP BY
	YEAR(published_date),
	MONTH(published_date)
ORDER BY 
	publish_year,
	publish_month

/*
Amazon Sales and Review Dataset

Skills used: Joins, CTE's, Temp Tables, Window Function, Aggregate function, Creating Views, Converting Data Types

*/

-- Testing to see if the dataset has been successfully integrated into SQL
SELECT *
FROM AmazonProject..Amazon_Price;

SELECT *
FROM AmazonProject..Amazon_Ratings;

-- Selecting Data that we are going to be starting with
SELECT Name, Brand, No_of_ratings, Rating, Sentiment
FROM AmazonProject..Amazon_Ratings
ORDER BY 1,2;

-- Comparing Average Rating to Brand
SELECT Brand, AVG(Rating) AS Avg_rating
FROM AmazonProject..Amazon_Ratings
GROUP BY Brand
ORDER BY Brand;

-- Comparing Total_ratings to Negative Sentiments
SELECT Brand, Sentiment, SUM(No_of_ratings) AS total_ratings
FROM AmazonProject..Amazon_Ratings
WHERE Sentiment = 'Negative'
GROUP BY Brand, Sentiment
ORDER BY SUM(No_of_ratings) DESC;

-- Diving deeper into the product the brand with the most Ratings that are Negative
SELECT Name, Brand, Sentiment, SUM(No_of_ratings) AS total_ratings, AVG(Rating) AS Avg_rating
FROM AmazonProject..Amazon_Ratings
WHERE Sentiment = 'Negative'
GROUP BY Name, Brand, Sentiment
ORDER BY SUM(No_of_ratings) DESC

-- The top 5 Brands withthe highest negative reviews: TPLink, MI, JBL, WIPRO, HP
SELECT DISTINCT(Brand), SUM(No_of_ratings) AS total_ratings, AVG(Rating) AS Avg_rating
FROM AmazonProject..Amazon_Ratings
WHERE Sentiment = 'Negative'
GROUP BY Brand
HAVING AVG(rating) = '1'
ORDER BY SUM(No_of_ratings) DESC


-- Viewing Reviews of the top 5 Brands and the Product with the highest Ratings that are Negative
-- Shows what is needed to be improved
SELECT Name, Brand, Cleaned_Review_Text, SUM(No_of_ratings) AS total_ratings, AVG(Rating) AS Avg_rating
FROM AmazonProject..Amazon_Ratings
WHERE Brand IN ('TPLink', 'MI', 'JBL', 'WIPRO', 'HP')
AND Sentiment = 'Negative'
GROUP BY Name, Brand, Cleaned_Review_Text
HAVING AVG(rating) = '1'
ORDER BY SUM(No_of_ratings) DESC

-- Viewing Products/ Brands with the most Positive Ratings
-- Top 5 Brands with the most Positive Ratings: Boya, Arctic, Syncwire, ENVIE, MemoHo
SELECT DISTINCT(Brand), SUM(No_of_ratings) AS total_ratings, AVG(Rating) AS Avg_rating
FROM AmazonProject..Amazon_Ratings
WHERE Sentiment = 'Positive'
GROUP BY Brand
HAVING AVG(rating) = '5'
ORDER BY SUM(No_of_ratings) DESC

-- Reviewing the Top 5 Brands with the most Positive Ratings
-- Shows what should be focused on and what other brands should use to improve their products

SELECT Name, Brand, Cleaned_Review_Text, SUM(No_of_ratings) AS total_ratings, AVG(Rating) AS Avg_rating
FROM AmazonProject..Amazon_Ratings
WHERE Brand IN ('Boya', 'Arctic', 'Syncwire', 'ENVIE', 'MemoHo')
AND Sentiment = 'Positive'
GROUP BY Name, Brand, Cleaned_Review_Text
HAVING AVG(rating) = '5'
ORDER BY SUM(No_of_ratings) DESC

-- Reviewing Amazon_Price and the dataset
SELECT *
FROM AmazonProject..Amazon_Price;

-- Breaking down Actual Price and the Discount Price for each Product
SELECT Name, Brand, (Actual_price - Discount_price) AS net_price
FROM AmazonProject..Amazon_Price;

-- Average Net price of each product
SELECT Name, Brand, AVG((Actual_price - Discount_price)) AS avg_net_price
FROM AmazonProject..Amazon_Price
GROUP BY name, brand

--Joining Amazon_ratings and Amazon_Price
SELECT R.name, R. brand, R.No_of_ratings, R.Rating, R. Review_text, R.Cleaned_review_text, R.Sentiment, P.Discount_Price, P.Actual_Price
FROM AmazonProject..Amazon_ratings AS R
JOIN AmazonProject..Amazon_Price AS P
	ON R.name = P.name

-- Grouping each Brand and their ratings count by their ratings
SELECT r. brand, r.rating, COUNT(CAST(r.rating AS int)) OVER (PARTITION BY r.no_of_ratings) AS total_ratings
FROM AmazonProject..Amazon_ratings AS R
JOIN AmazonProject..Amazon_Price AS P
	ON R.name = P.name
ORDER BY r.brand

-- Using CTE to perform Calculation on Partition By in the previous query
-- The dataset calculates the average total ratings based on the grouping of ratings per brand
WITH BrandRatingCt (brand, rating, total_ratings)
AS
(
SELECT r. brand, r.rating, COUNT(CONVERT(int, r.rating)) OVER (PARTITION BY r.no_of_ratings) AS total_ratings
FROM AmazonProject..Amazon_ratings AS R
JOIN AmazonProject..Amazon_Price AS P
	ON R.name = P.name
)
SELECT brand, rating, AVG(total_ratings) AS avg_total_ratings
FROM BrandRatingCt
GROUP BY brand, rating

-- Using CTE to compare the Average total price (price after discount) for each Brand
WITH total_price (brand, actual_price, discount_price, net_price) AS
(
SELECT r. brand, p.actual_price, p.discount_price, (p.actual_price - p.discount_price) AS net_price
FROM AmazonProject..Amazon_ratings AS R
JOIN AmazonProject..Amazon_Price AS P
	ON R.name = P.name
)
SELECT DISTINCT(brand), AVG(net_price) OVER(PARTITION BY brand) AS avg_net_price
FROM total_price

-- Using Temp tables to perform Calculation on Partition By in Previous Query to calculate the discount percentage
DROP TABLE IF EXISTS #total_net_price
CREATE TABLE #total_net_price
(
brand nvarchar (255),
actual_price numeric,
discount_price numeric,
avg_net_price numeric
)

INSERT INTO #total_net_price
SELECT DISTINCT(r. brand), p.actual_price, p.discount_price, AVG((p.actual_price - p.discount_price)) OVER(PARTITION BY r.brand) AS avg_net_price
FROM AmazonProject..Amazon_ratings AS R
JOIN AmazonProject..Amazon_Price AS P
	ON R.name = P.name

SELECT *, (avg_net_price/actual_price)*100 AS discount_percentage
FROM #total_net_price

--Create View to store data for later visualizations
CREATE VIEW total_net_price AS
SELECT DISTINCT(r. brand), p.actual_price, p.discount_price, 
AVG((p.actual_price - p.discount_price)) OVER(PARTITION BY r.brand) AS avg_net_price,
AVG(r.rating) OVER(PARTITION BY r.brand) AS avg_rating
FROM AmazonProject..Amazon_ratings AS R
JOIN AmazonProject..Amazon_Price AS P
	ON R.name = P.name
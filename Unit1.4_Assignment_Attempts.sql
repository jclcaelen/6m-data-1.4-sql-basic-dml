-- Assignment
-- Prop Analyst 3 QNs:
		-- i. Find the average resale_price per town.
SELECT
  town,
  ROUND(AVG(resale_price),2) AS avg_price_town
FROM resale_flat_prices_2017
GROUP BY town;

		-- ii. Filter for towns where the average price is less than $450,000.
SELECT
  town,
  ROUND(AVG(resale_price),2) AS avg_price_town
FROM resale_flat_prices_2017
GROUP BY town
HAVING avg_price_town < 450000;

		-- iii. Within those towns, find the top 5 largest flats (by floor_area_sqm) currently available.
				-- Per peeking solution, the ultimate goal is to find 5 largest flat regardless of town, from the filtered towns in part (ii)

SELECT *
FROM resale_flat_prices_2017
WHERE town IN (
	SELECT
	  town,
	  -- ROUND(AVG(resale_price),2) AS avg_price_town --> we can omit this as we only want the towns to be the values for the main query filter condition
	FROM resale_flat_prices_2017
	GROUP BY town
	HAVING AVG(resale_price) < 450000 			-- we cannot use alias because the definition is removed. since we need not display, we can remove the optional ROUND()
)
ORDER BY floor_area_sqm DESC
LIMIT 5;



-- Level Up: Create a new column called price_per_sqm and find which town has the lowest average price per square meter.
-- Did in my self-practice earlier
SELECT 
	town,
	ROUND(AVG(resale_price / floor_area_sqm),2) as avg_psm		-- since explicitly to create the new column
FROM resale_flat_prices_2017
GROUP BY town
ORDER BY avg_psm ASC
LIMIT 1;

-- Qn1-4:
-- 1. Select the minimum and maximum price per sqm of all the flats.
	-- Since earlier we retrieve the minimum, below is the maximum:
SELECT 
	town,
	ROUND(AVG(resale_price / floor_area_sqm),2) as avg_psm
FROM resale_flat_prices_2017
GROUP BY town
ORDER BY avg_psm DESC
LIMIT 1;

-- Solution is just clear cut to find the min and max, not average
SELECT
	MIN(resale_price / floor_area_sqm) as min_psm,
	MAX(resale_price / floor_area_sqm) as max_psm
FROM resale_flat_prices_2017;

-- 2. Select the average price per sqm for flats in each town.
SELECT 
	town,
	ROUND(AVG(resale_price / floor_area_sqm),2) as avg_psm		-- since explicitly to create the new column
FROM resale_flat_prices_2017
GROUP BY town
ORDER BY town;

-- 3. Categorize flats into price ranges and count how many flats fall into each category:
		-- Under $400,000: 'Budget'
		-- $400,000 to $700,000: 'Mid-Range'
		-- Above $700,000: 'Premium' Show the counts in descending order.
SELECT
price_category,
COUNT(price_category)
FROM (
	SELECT
		town,
		CASE
		    WHEN resale_price > 700000 THEN 'Premium'
			WHEN resale_price >= 400000 THEN 'Mid-Range'
			ELSE 'Budget'
	  	END AS price_category
	FROM resale_flat_prices_2017
)
GROUP BY price_category
ORDER BY COUNT(price_category) DESC; 

-- Solution
SELECT 
    CASE 
        WHEN resale_price < 400000 THEN 'Budget'
        WHEN resale_price <= 700000 THEN 'Mid-Range'
        ELSE 'Premium' 
    END AS price_category,
    COUNT(*) AS number_of_flats
FROM resale_flat_prices_2017
GROUP BY price_category
ORDER BY number_of_flats DESC;

-- Placeholder to verify to total
SELECT Count(*)
FROM resale_flat_prices_2017;


GROUP BY town
ORDER BY town;
-- 4. Count the number of flats sold in each town during the first quarter of 2017 (January to March).
		-- Step 1: Filter by Q1 2017 with WHERE
		-- Step 2: Group By town
SELECT
	town,
	Count(*) as num_of_flats
FROM resale_flat_prices_2017
WHERE month IN ('2017-01', '2017-02', '2017-03')		-- selected this format because it is 3 values of query complexity and laziness
GROUP BY town
ORDER BY num_of_flats;
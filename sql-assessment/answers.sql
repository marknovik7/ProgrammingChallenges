--Mark Grivnin PMG technical assessment


-- Question 1
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY date
ORDER BY date;

-- Question 2
SELECT state, sum(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue
DESC
LIMIT 3;
-- 3rd best state, Ohio, generated $37,577

-- Question 3
-- need to create left joins here to map IDs across tables
SELECT ci.name AS campaign_name,
       SUM(mp.cost) AS total_cost,
       SUM(mp.impressions) AS total_impressions,
       SUM(mp.clicks) AS total_clicks,
       SUM(wr.revenue) AS total_revenue
FROM campaign_info ci
LEFT JOIN marketing_performance mp ON ci.id = mp.campaign_id
LEFT JOIN website_revenue wr ON ci.id = wr.campaign_id
GROUP BY ci.name;

-- Question 4
SELECT mp.geo AS state, ci.name AS campaign_name, SUM(mp.conversions) AS total_conversions
FROM marketing_performance mp
LEFT JOIN campaign_info ci ON mp.campaign_id = ci.id
WHERE ci.name = "Campaign5"
GROUP BY mp.geo;

/* Question 5
We can measure efficiency by revenue/cost of each campaign
to see which is highest. This will result in the most profitable campaign.
In this case, it seems like Campaign 4 is the most profitable/efficiency
*/
SELECT ci.name AS campaign_name, sum(wr.revenue)/sum(mp.cost) AS effeciency
FROM campaign_info ci
LEFT JOIN marketing_performance mp ON ci.id = mp.campaign_id
LEFT JOIN website_revenue wr ON ci.id = wr.campaign_id
GROUP BY ci.name
ORDER BY effeciency DESC
LIMIT 1;

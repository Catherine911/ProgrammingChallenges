/* 1. */
SELECT date, SUM(impressions) as total_impressions
FROM marketing_performance
GROUP BY date

/* 2. */
SELECT state, SUM(revenue) as total_revenue
FROM website_revenue
GROUP BY state
ORDER BY SUM(revenue) DESC
LIMIT 3
/* The state that generated the third highest revenue is Ohio. It generated 37577. */

/* 3. */
SELECT name, SUM(cost) as campaign_cost, SUM(impressions) as campaign_impressions, SUM(clicks) as campaign_clicks, SUM(revenue) as campaign_revenue
FROM marketing_performance mp
LEFT JOIN website_revenue wr ON mp.campaign_id = wr.campaign_id
LEFT JOIN campaign_info ci ON mp.campaign_id = ci.id
GROUP BY mp.campaign_id

/* 4. */
SELECT geo, SUM(conversions) as total_conversions
FROM marketing_performance mp, campaign_info ci
WHERE mp.campaign_id = ci.id AND ci.name = 'Campaign5'
/* GA generated the most conversions for this campaign, with 672. */

/* 5. */
SELECT name, mp.campaign_id, SUM(revenue)/SUM(cost) as ROI
FROM website_revenue wr, campaign_info ci, marketing_performance mp
WHERE wr.campaign_id = ci.id, ci.id = mp.campaign_id
GROUP BY campaign_id
ORDER BY SUM(revenue)/SUM(cost) DESC
LIMIT 1
/* I define efficiency as the ratio between revenue and cost. The higher the ratio is, the more efficient the campaign is. The campaign with highest revenue-to-cost ratio is Campaign4, with the ratio being 41.16.*/

/* 6. */
SELECT DATENAME(dw, mp.date) day_of_week, SUM(revenue)/SUM(cost) as ROI
FROM marketing_performance mp, website_revenue wr
WHERE wr.campaign_id = mp.campaign_id
GROUP BY DATENAME(dw, mp.date)
ORDER BY SUM(revenue)/SUM(cost) DESC
LIMIT 1
/* The most efficient day of the week is Friday, with the ROI being 40.761223. */
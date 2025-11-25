-- car makes and models generate the most revenue 
SELECT DISTINCT  year,make,model,color,interior,body,
SUM(sellingprice) AS total_revenue,
COUNT(*) AS units_sold,
MONTHNAME(TRY_TO_TIMESTAMP_NTZ(saledate,'DY MON DD YYYY HH24:MI:SS')) AS month_sale,

--The relationship between price, mileage, and year of manufacture 
ROUND(AVG(sellingprice),2) AS avg_price,
ROUND(AVG(odometer),0) AS avg_mileage,

-- Emerging trends in customer purchasing preferences 
CASE
    WHEN sellingprice > mmr THEN 'Above Market'
    WHEN sellingprice < mmr THEN 'Below Market'
    ELSE 'At Market'
  END AS market_position
  From car.sales.car_sales_db
  WHERE sellingprice IS NOT NULL
  AND odometer IS NOT NULL
  AND year IS NOT NULL
GROUP BY year,make,model,color,interior,body,MONTHNAME(TRY_TO_TIMESTAMP_NTZ(saledate,'DY MON DD YYYY HH24:MI:SS')),
CASE
    WHEN sellingprice > mmr THEN 'Above Market'
    WHEN sellingprice < mmr THEN 'Below Market'
        ELSE 'At Market' 
        END
 ORDER BY total_revenue DESC
 LIMIT 3000;

 


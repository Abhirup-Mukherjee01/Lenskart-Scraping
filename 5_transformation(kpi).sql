--Top 15 highly rated products
SELECT TOP (15) [id]
      ,[color]
      ,[size]
      ,[width]
      ,[brand_name_en]
      ,[model_name]
      ,[Market_Price]
      ,[Lenskart_Price]
      ,[totalColorAvailable]
      ,[sku]
      ,[wishlistCount]
      ,[purchaseCount]
      ,[avgRating]
      ,[totalNoOfRatings]
      ,[qty]
  FROM [transformation].[trns_productTable]
  order by avgRating*totalNoOfRatings desc

--Average transaction by Payment type
SELECT payment_method, SUM(Lenskart_Price) AS total_transaction_amount ,AVG(Lenskart_Price) AS average_transaction_price
FROM [transformation].trns_transactionTable tt
INNER JOIN [transformation].trns_productTable tp ON tt.product_id = tp.id
GROUP BY payment_method;

--current year revenue vs every year revenue
SELECT YEAR(order_date) AS year,
       SUM(tp.Lenskart_Price * tt.quantity) AS total_revenue
FROM [transformation].trns_transactionTable tt
INNER JOIN [transformation].trns_productTable tp ON tt.product_id = tp.id
GROUP BY YEAR(order_date)
ORDER BY year ASC;

--Top 10 product revenue in last 30 days
WITH RevenuePerProduct AS (
  SELECT 
    t.product_id,
    p.Lenskart_Price * t.quantity AS revenue
  FROM [transformation].trns_transactionTable t
  INNER JOIN [transformation].trns_productTable p ON t.product_id = p.id
)
SELECT top (10) 
  t.product_id,
  SUM(revenue) AS total_revenue
FROM RevenuePerProduct,[transformation].trns_transactionTable as t,[transformation].trns_productTable as p
WHERE YEAR(order_date) = 2024
  AND MONTH(order_date) = 4
  and t.product_id = p.id
GROUP BY t.product_id
ORDER BY total_revenue DESC

-- Compare the count of sales Transaction over a period between the current year and previous year
WITH MonthlySales AS (
  SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(t.quantity * p.Lenskart_Price) AS total_sales
  FROM [transformation].trns_transactionTable t
  INNER JOIN [transformation].trns_productTable p ON t.product_id = p.id
  GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
  y.year AS Year,
  (SELECT SUM(CASE WHEN ms.month = 1 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS January,
  (SELECT SUM(CASE WHEN ms.month = 2 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS February,
  (SELECT SUM(CASE WHEN ms.month = 3 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS March,
  (SELECT SUM(CASE WHEN ms.month = 4 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS April,
  (SELECT SUM(CASE WHEN ms.month = 5 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS May,
  (SELECT SUM(CASE WHEN ms.month = 6 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS June,
  (SELECT SUM(CASE WHEN ms.month = 7 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS July,
  (SELECT SUM(CASE WHEN ms.month = 8 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS Auguest,
  (SELECT SUM(CASE WHEN ms.month = 9 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS September,
  (SELECT SUM(CASE WHEN ms.month = 10 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS October,
  (SELECT SUM(CASE WHEN ms.month = 11 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS November,
  (SELECT SUM(CASE WHEN ms.month = 12 THEN ms.total_sales ELSE 0 END) FROM MonthlySales ms WHERE ms.year = y.year) AS December
  
FROM (
  SELECT DISTINCT year
  FROM MonthlySales
) AS y
ORDER BY y.year DESC;
===========================================================================================================================================
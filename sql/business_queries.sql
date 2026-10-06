-- Query 1: Total Revenue

SELECT SUM(s.quantity * m.unit_price) AS Total_Revenue
FROM sales s
JOIN medicines m
ON s.medicine_id = m.medicine_id;


-- Query 2: Total Revenue by Region

SELECT
r.region_name,
SUM(s.quantity * m.unit_price) AS Revenue
FROM sales s
JOIN medicines m ON s.medicine_id = m.medicine_id
JOIN sales_reps sr ON s.rep_id = sr.rep_id
JOIN regions r ON sr.region_id = r.region_id
GROUP BY r.region_name
ORDER BY Revenue DESC;


-- Query 3: Top Products

SELECT
m.medicine_name,
SUM(s.quantity) AS UnitsSold,
SUM(s.quantity * m.unit_price) AS Revenue
FROM sales s
JOIN medicines m
ON s.medicine_id = m.medicine_id
GROUP BY m.medicine_name
ORDER BY Revenue DESC;


-- Query 4: Top Doctors

SELECT
d.doctor_name,
SUM(s.quantity * m.unit_price) AS Revenue
FROM sales s
JOIN doctors d
ON s.doctor_id = d.doctor_id
JOIN medicines m
ON s.medicine_id = m.medicine_id
GROUP BY d.doctor_name
ORDER BY Revenue DESC
LIMIT 10;


-- Query 5: Top Sales Representatives

SELECT
sr.rep_name,
SUM(s.quantity * m.unit_price) AS Revenue
FROM sales s
JOIN sales_reps sr
ON s.rep_id = sr.rep_id
JOIN medicines m
ON s.medicine_id = m.medicine_id
GROUP BY sr.rep_name
ORDER BY Revenue DESC;


-- Query 6: Month Wise Revenues

SELECT
DATE_FORMAT(s.sale_date,'%Y-%m') AS Month,
SUM(s.quantity * m.unit_price) AS Revenue
FROM sales s
JOIN medicines m
ON s.medicine_id = m.medicine_id
GROUP BY DATE_FORMAT(s.sale_date,'%Y-%m')
ORDER BY Month;


-- Query 7: Top 5 Territories

SELECT *
FROM
(
SELECT
r.region_name,
SUM(s.quantity * m.unit_price) AS Revenue,
DENSE_RANK() OVER(
ORDER BY SUM(s.quantity * m.unit_price) DESC
) AS RankNo
FROM sales s
JOIN medicines m
ON s.medicine_id = m.medicine_id
JOIN sales_reps sr
ON s.rep_id = sr.rep_id
JOIN regions r
ON sr.region_id = r.region_id
GROUP BY r.region_name
) x
WHERE RankNo <= 5;
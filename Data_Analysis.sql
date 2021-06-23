
---Project Data Analysis for Retail : Sales Performance Report

---1 Overall Performance DQLab Store tahun 2009 - 2012 untuk jumlah order dan total sales order finished
---2 Overall performance DQLab by subcategory product yang akan dibandingkan antara tahun 2011 dan tahun 2012
---3 Efektifitas dan efisiensi promosi yang dilakukan selama ini, dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan tahun
---4 Efektifitas dan efisiensi promosi yang dilakukan selama ini, dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan sub-category
---5 Analisa terhadap customer setiap tahunnya
---6 Analisa terhadap jumlah customer baru setiap tahunnya

---SQL Script
---1
SELECT YEAR(order_date) AS years, SUM(sales) AS sales, COUNT(order_id) AS number_of_order FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years;

---2
SELECT YEAR(order_date) AS years, product_sub_category, SUM(sales) AS sales FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
AND
order_date between '2011-01-01' AND '2012-12-31'
GROUP BY years, product_sub_category
ORDER BY years, sales DESC;

---3
SELECT YEAR(order_date) AS years, SUM(sales) AS sales, SUM(discount_value) AS promotion_value, ROUND(SUM(discount_value)*100/SUM(sales),2) AS burn_rate_percentage FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years
ORDER BY years;

---4
SELECT YEAR(order_date) AS years, product_sub_category, product_category, SUM(sales) AS sales, SUM(discount_value) AS promotion_value, ROUND(SUM(discount_value)*100/SUM(sales),2) AS burn_rate_percentage FROM dqlab_sales_store
WHERE order_status = 'Order Finished' AND YEAR(order_date) ='2012'
GROUP BY years, product_sub_category, product_category
ORDER BY sales DESC;

---5
SELECT YEAR(order_date) AS years, COUNT(DISTINCT customer) AS number_of_customer FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years;

---6
SELECT YEAR(first_order) years, COUNT(customer) 'new customers' FROM(
    SELECT customer, MIN(order_date) first_order FROM dqlab_sales_store
    WHERE order_status = 'Order Finished'
    GROUP BY 1) first
GROUP BY 1;
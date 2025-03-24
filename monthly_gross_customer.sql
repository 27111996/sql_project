CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_for_customer`(
      in_customer_code int)
BEGIN
SELECT 
            s.date, 
    	    SUM(ROUND(s.sold_quantity*g.gross_price,2)) as monthly_sales
	FROM fact_sales_monthly s
	JOIN fact_gross_price g
        ON g.fiscal_year=get_fiscal_year(s.date) 
        AND g.product_code=s.product_code
	WHERE 
         find_in_set(s.customer_code, in_customer_code)>0
	GROUP BY date;
END
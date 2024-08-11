SELECT *, (SELECT customer_id FROM orders WHERE id = order_details.order_id) AS order_customer_id
FROM order_details;

SELECT *
FROM order_details
WHERE order_id = (SELECT id FROM orders WHERE shipper_id = 3 AND id = order_details.order_id);

SELECT order_id, AVG(quantity) AS avg_quantity
FROM (SELECT * FROM order_details WHERE quantity > 10) AS temp_table
GROUP BY order_id;

WITH temp_table AS (
	SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp_table
GROUP BY order_id;


DELIMITER //

DROP FUNCTION IF EXISTS AB_divider;
CREATE FUNCTION AB_divider(input_number1 FLOAT, input_number2 FLOAT)
RETURNS FLOAT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = input_number1 / input_number2;
    RETURN result;
END //

DELIMITER ;

SELECT AB_divider(quantity, 10) FROM order_details;
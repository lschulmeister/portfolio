CREATE VIEW vw_invoicing AS
SELECT ord.id
, ord.order_date
, ctm.cnpj
, ctm.c_name as client
, ctm.phone as telefone
, ctm.state	as client_state
, ctm.city	as client_city
, CONCAT(emp.f_name,' ',emp.l_name) as seller
, emp.state as seller_state
, emp.city	as seller_city
, prd.brand
, prd.model
, pay.payment_method
, ors.quantity
, pro.price
, pay.amount
, pay.payment_date
, pay.payment_status
FROM orders ord
JOIN customers ctm
	ON ord.customer_id = ctm.id
JOIN employees emp
	ON ord.employee_id = emp.id 
JOIN orders_details ors
	ON ord.id = ors.orders_id
JOIN payment pay
	ON ord.payment_id = pay.id
JOIN product pro
	ON ors.product_id = pro.id
JOIN product_details prd
	ON pro.details_id = prd.id
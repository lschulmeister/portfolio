-- Novo Produto
--CALL public.new_product('Nome Produto', 879.00, 'Marca', 'Modelo', 1988, 'Descricao', null);
CREATE OR REPLACE PROCEDURE new_product (
	in_product_name varchar(100),
	in_price numeric(10,2),
	in_brand varchar(50),
	in_model varchar(50),
	in_product_year INTEGER,
	in_product_description varchar(150),
	used_id bigint)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO product_details(brand, model, product_year, product_description)
	VALUES (in_brand, in_model, in_product_year, in_product_description)
	RETURNING id INTO used_id;
	
	INSERT INTO product(product_name, price, details_id)
	VALUES (in_product_name, in_price, used_id);
	
END;
$$;

-- Novo pedido
-- CALL public.new_order(1, 1, '2022-12-21 16:04:05.211', 3000, 2, null, null);
CREATE OR REPLACE PROCEDURE new_order (
	in_customer_id bigint,
    in_employee_id bigint,
    in_order_date timestamp,
	in_product_id bigint,
	in_quantity integer,
	pay_id bigint,
	ord_id bigint)
LANGUAGE plpgsql
AS $$
BEGIN
		
	INSERT INTO payment (payment_method, amount, payment_status)
	VALUES ('0000000', 0, 'awaiting')
	RETURNING id INTO pay_id;
	
	INSERT INTO orders (customer_id, customer_name, employee_id, employee_name, order_date, payment_id)
	SELECT in_customer_id, (SELECT c_name FROM customers WHERE id = in_customer_id), in_employee_id, (SELECT f_name FROM employees WHERE id = in_employee_id), in_order_date, pay_id
	RETURNING id INTO ord_id;
	
	INSERT INTO orders_details (orders_id, product_id, product_name, quantity)
	SELECT ord_id, in_product_id, (SELECT product_name FROM product WHERE id = in_product_id), in_quantity;
	
END;
$$;

-- Pagamento
-- CALL public.payment('1', '2022-12-28')
CREATE OR REPLACE PROCEDURE payment (
	in_payment_method varchar(30),
	in_order_date date)
LANGUAGE plpgsql
AS $$
BEGIN

	INSERT INTO payment (id, payment_method, amount, payment_date, payment_status)
	SELECT pay.id
	, in_payment_method
	, (ors.quantity * pro.price)
	, NOW()
	, CASE
	WHEN in_payment_method = '1' THEN 'confirmed'
	WHEN in_payment_method = '-1' THEN 'canceled'
	ELSE 'error'
	END
	FROM payment pay
	JOIN orders ord
		ON pay.id = ord.payment_id
	JOIN orders_details ors
		ON ord.id = ors.orders_id
	JOIN product pro
		ON ors.product_id = pro.id
	WHERE pay.payment_date is null
	AND pay.amount = 0
	AND ord.order_date::date <= in_order_date
	ON CONFLICT (id) DO UPDATE
	SET payment_method = EXCLUDED.payment_method,
	amount = EXCLUDED.amount,
	payment_date = EXCLUDED.payment_date,
	payment_status = EXCLUDED.payment_status;
	
END;
$$;


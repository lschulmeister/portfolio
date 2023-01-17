CREATE TABLE public.product (
    id SERIAL NOT NULL,
    product_name varchar(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    details_id bigint NOT NULL,
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    active boolean default TRUE,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.product(id);
CREATE INDEX ON public.product(details_id);


CREATE TABLE public.customers (
    id SERIAL NOT NULL,
    cnpj bigint NOT NULL,
    c_name varchar(100) NOT NULL,
    e_mail varchar(40) NOT NULL,
    phone varchar(20),
    state varchar(50),
    city varchar(50),
    customer_address varchar(150),
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    active boolean default TRUE,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.customers(id);

CREATE TABLE public.employees (
    id SERIAL NOT NULL,
    f_name varchar(50) NOT NULL,
    l_name varchar(50) NOT NULL,
    state varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    active boolean default TRUE,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.employees(id);

CREATE TABLE public.orders (
    id SERIAL NOT NULL,
    customer_id bigint NOT NULL,
    customer_name varchar(100) NOT NULL,
    employee_id bigint NOT NULL,
    employee_name varchar(50) NOT NULL,
    order_date timestamp without time zone NOT NULL,
    payment_id bigint NOT NULL,
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    active boolean default TRUE,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.orders(id);
CREATE INDEX ON public.orders(customer_id);
CREATE INDEX ON public.orders(employee_id);
CREATE INDEX ON public.orders(payment_id);


CREATE TABLE public.product_details (
    id SERIAL NOT NULL,
    brand varchar(50),
    model varchar(50),
    product_year integer,
    product_description varchar(150),
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.product_details(id);

CREATE TABLE public.payment (
    id SERIAL NOT NULL,
    payment_method varchar(30) NOT NULL,
    amount numeric(16,2) NOT NULL,
    payment_date timestamp without time zone,
    payment_status varchar(15) default 0 NOT NULL,
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.payment(id);

CREATE TABLE public.orders_details (
    id SERIAL NOT NULL,
    orders_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_name varchar(100) NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp default CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);
CREATE INDEX ON public.orders_details(id);
CREATE INDEX ON public.orders_details(orders_id);
CREATE INDEX ON public.orders_details(product_id);


ALTER TABLE public.product ADD CONSTRAINT FK_product__details_id FOREIGN KEY (details_id) REFERENCES public.product_details(id);
ALTER TABLE public.orders ADD CONSTRAINT FK_orders__customer_id FOREIGN KEY (customer_id) REFERENCES public.customers(id);
ALTER TABLE public.orders ADD CONSTRAINT FK_orders__employee_id FOREIGN KEY (employee_id) REFERENCES public.employees(id);
ALTER TABLE public.orders ADD CONSTRAINT FK_orders__payment_id FOREIGN KEY (payment_id) REFERENCES public.payment(id);
ALTER TABLE public.orders_details ADD CONSTRAINT FK_orders_details__orders_id FOREIGN KEY (orders_id) REFERENCES public.orders(id);
ALTER TABLE public.orders_details ADD CONSTRAINT FK_orders_details__product_id FOREIGN KEY (product_id) REFERENCES public.product(id);
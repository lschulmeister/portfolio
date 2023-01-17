CREATE TRIGGER tr_updated_at_customers
    BEFORE UPDATE ON customers
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();


CREATE TRIGGER tr_updated_at_employees
    BEFORE UPDATE ON employees
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();


CREATE TRIGGER tr_updated_at_orders
    BEFORE UPDATE ON orders
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();

CREATE TRIGGER tr_updated_at_orders_details
    BEFORE UPDATE ON orders_details
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();

CREATE TRIGGER tr_updated_at_payment
    BEFORE UPDATE ON payment
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();


CREATE TRIGGER tr_updated_at_product
    BEFORE UPDATE ON product
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();


CREATE TRIGGER tr_updated_at_product_details
    BEFORE UPDATE ON product_details
    FOR EACH ROW
EXECUTE PROCEDURE fn_updated_at_task();

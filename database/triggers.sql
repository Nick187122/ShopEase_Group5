-- Trigger configuration for ShopEase


-- Optional supporting tables for order flow (created only if missing).
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0)
);

CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0)
);

-- Trigger function: validates stock and decrements inventory.
CREATE OR REPLACE FUNCTION decrement_inventory_on_order_item()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INTEGER;
BEGIN
    SELECT stock
    INTO current_stock
    FROM products
    WHERE id = NEW.product_id;

    IF current_stock IS NULL THEN
        RAISE EXCEPTION 'Product % does not exist', NEW.product_id;
    END IF;

    IF current_stock < NEW.quantity THEN
        RAISE EXCEPTION 'Insufficient stock for product % (available: %, requested: %)', NEW.product_id, current_stock, NEW.quantity;
    END IF;

    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_decrement_inventory_on_order_item ON order_items;

CREATE TRIGGER trg_decrement_inventory_on_order_item
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION decrement_inventory_on_order_item();

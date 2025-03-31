-- Sicherstellen, dass das "public" Schema genutzt wird
SET search_path TO public;

-- Displays Table
CREATE TABLE IF NOT EXISTS displays (
    id SERIAL PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    is_food INTEGER NOT NULL
);

INSERT INTO displays (id, display_name, is_food) VALUES (1, 'Food', 1);
INSERT INTO displays (id, display_name, is_food) VALUES (2, 'Drink', 0);

-- Waiters Table
CREATE TABLE IF NOT EXISTS waiters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    earned_money NUMERIC(10,2) NULL,
    uuid VARCHAR(255) NOT NULL
);

INSERT INTO waiters (id, name, earned_money, uuid) VALUES (1, 'JackyJack', 330, 'SHA2233993');
INSERT INTO waiters (id, name, earned_money, uuid) VALUES (2, 'Oleg', 3281, 'SHA12445559');

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    order_date VARCHAR(255) NOT NULL,
    is_done INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL,
    desk_number VARCHAR(255) NOT NULL,
    order_sum DOUBLE PRECISION NOT NULL,
    waiter_id INTEGER NULL,
    CONSTRAINT fk_orders_waiters FOREIGN KEY (waiter_id) REFERENCES waiters (id)
);

INSERT INTO orders (id, order_date, is_done, type, desk_number, order_sum, waiter_id) VALUES 
(51, '18.03.2025 10:22:13', 0, 'Order', '11', 41.0, 2),
(53, '18.03.2025 10:44:11', 0, 'Food and Drink Order', '8', 36.25, 2),
(54, '18.03.2025 10:44:51', 0, 'Drink Order', '1', 8.0, 2),
(55, '18.03.2025 10:44:57', 0, 'Food Order', '1', 21.75, 2),
(56, '18.03.2025 10:47:55', 0, 'Food and Drink Order', '1', 27.5, 2),
(57, '18.03.2025 11:16:14', 0, 'Food and Drink Order', '1', 36.25, 2),
(58, '18.03.2025 11:20:18', 0, 'Food and Drink Order', '8', 24.25, 2);

-- Drinks Table
CREATE TABLE IF NOT EXISTS drinks (
    id SERIAL PRIMARY KEY,
    drink_name VARCHAR(255) NOT NULL,
    drink_price DOUBLE PRECISION NOT NULL,
    order_id INTEGER NULL,
    CONSTRAINT fk_drinks_orders FOREIGN KEY (order_id) REFERENCES orders (id)
);

INSERT INTO drinks (id, drink_name, drink_price, order_id) VALUES 
(2, 'Bier', 4.5, 58),
(3, 'Wein', 8.0, 56),
(4, 'Cola', 3.5, 54),
(5, 'Fanta', 4.0, NULL),
(6, 'Mojito', 8.9, NULL),
(8, 'Weizen', 4.4, NULL),
(10, 'Ayran', 4.4, NULL),
(11, 'Cuba Libre', 8.5, NULL),
(15, 'Cola Zero', 3.0, NULL),
(16, 'Sangria', 7.0, NULL),
(17, 'Long Island', 8.0, 58),
(19, 'Wasser still', 1.0, NULL),
(20, 'Soda Zitrone', 3.0, NULL);

-- Foods Table
CREATE TABLE IF NOT EXISTS foods (
    id SERIAL PRIMARY KEY,
    food_name VARCHAR(255) NOT NULL,
    food_price DOUBLE PRECISION NOT NULL,
    order_id INTEGER NULL,
    CONSTRAINT fk_foods_orders FOREIGN KEY (order_id) REFERENCES orders (id)
);

INSERT INTO foods (id, food_name, food_price, order_id) VALUES 
(3, 'Penne', 10.0, 57),
(4, 'Sushi', 11.75, 58),
(8, 'Ente süß sauer', 21.0, NULL),
(9, 'Hamburger', 12.0, 51),
(10, 'Cheeseburger', 9.0, NULL),
(11, 'Leberkäsesemmel', 4.0, NULL),
(12, 'Chips', 3.0, NULL),
(13, 'Erdnüsse', 3.0, NULL),
(14, 'Haribo', 2.0, NULL),
(15, 'Pizza Margarita', 7.0, NULL),
(16, 'Pizza Salami', 6.0, 56),
(17, 'Pizza Calzone', 9.0, 56),
(18, 'Bärlauchspaghetti', 44.0, NULL),
(19, 'Schnitzel', 12.13, NULL);

-- Indizes setzen
CREATE INDEX idx_drinks_order_id ON drinks (order_id);
CREATE INDEX idx_foods_order_id ON foods (order_id);
CREATE INDEX idx_orders_waiter_id ON orders (waiter_id);

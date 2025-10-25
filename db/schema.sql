USE bookstore_test;

-- USER table
CREATE TABLE IF NOT EXISTS User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('employee', 'customer', 'admin') NOT NULL DEFAULT 'customer',
    two_factor_code VARCHAR(10) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- PUBLISHERS table
CREATE TABLE IF NOT EXISTS publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    address TEXT,
    contact_phone VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- AUTHORS table
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    bio TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- BOOKS table
CREATE TABLE IF NOT EXISTS books (
    isbn VARCHAR(13) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    publisher_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subject_area VARCHAR(200),
    year_published YEAR,
    pages INT,
    language VARCHAR(50),
    CONSTRAINT fk_books_publisher FOREIGN KEY (publisher_id)
        REFERENCES publishers(publisher_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- BOOK_AUTHORS table (many-to-many between books and authors)
CREATE TABLE IF NOT EXISTS book_authors (
    book_isbn VARCHAR(13) NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_isbn, author_id),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_isbn)
        REFERENCES books(isbn)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ba_author FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- INVENTORY table
CREATE TABLE IF NOT EXISTS inventory (
    isbn VARCHAR(13) PRIMARY KEY,
    quantity_on_hand INT NOT NULL DEFAULT 0,
    quantity_on_order INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 5,
    CONSTRAINT fk_inventory_book FOREIGN KEY (isbn)
        REFERENCES books(isbn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CUSTOMERS table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    phone VARCHAR(30),
    address TEXT,
    reading_preferences VARCHAR(255),
    profession VARCHAR(100),
    CONSTRAINT fk_customer_user FOREIGN KEY (user_id)
        REFERENCES User(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDERS table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending','paid','shipped','partial','cancelled') DEFAULT 'pending',
    payment_method VARCHAR(50),
    shipping_address TEXT,
    is_partial_allowed BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDER_ITEMS table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderitems_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderitems_book FOREIGN KEY (isbn)
        REFERENCES books(isbn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- PAYMENTS table
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    transaction_reference VARCHAR(255),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- REVIEWS table
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    rating TINYINT,
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_reviews_book FOREIGN KEY (isbn)
        REFERENCES books(isbn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
<<<<<<< HEAD
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
=======
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
>>>>>>> 0c299a25240755d2d1f7074f9fcd5efa42e8f965

USE bookstore_test;

-- ➕ More Users
INSERT INTO User (email, password_hash, role, two_factor_code)
VALUES
('mark@bookstore.com', SHA2('lucypass', 256), 'customer', NULL),
('kimberly@bookstore.com', SHA2('dennispass', 256), 'customer', NULL),
('zack@bookstore.com', SHA2('gracepass', 256), 'customer', NULL),
('william@bookstore.com', SHA2('kevinpass', 256), 'employee', NULL),
('fidel@bookstore.com', SHA2('stevepass', 256), 'admin', NULL),
('rita@bookstore.com', SHA2('ritapass', 256), 'customer', NULL);

-- ➕ More Authors
INSERT INTO authors (name, bio)
VALUES
('Chimamanda Adichie', 'Author of acclaimed African literature.'),
('George Martin', 'Famous fantasy writer and storyteller.'),
('David Green', 'Business analyst and systems researcher.');

-- ➕ More Books
INSERT INTO books (isbn, title, publisher_id, price, subject_area, year_published, pages, language)
VALUES
('9780439023528', 'The Rising Dawn', 1, 2500.00, 'Fiction', 2019, 410, 'English'),
('9780439139595', 'Game of Codes', 2, 3900.00, 'Fantasy Programming', 2020, 700, 'English'),
('9781526604736', 'Purple Hibiscus', 3, 2200.00, 'Literature', 2017, 350, 'English'),
('9780132350884', 'Clean Code', 1, 4500.00, 'Software Engineering', 2016, 464, 'English'),
('9781492078005', 'Data-Driven Systems', 2, 3800.00, 'Data Science', 2023, 512, 'English'),
('9781501124020', 'African Women Speak', 3, 2100.00, 'Culture', 2021, 280, 'English'),
('9781118531648', 'Business Systems Analysis', 2, 3600.00, 'Information Systems', 2020, 390, 'English');

-- ➕ Link new books to authors
INSERT INTO book_authors (book_isbn, author_id)
VALUES
('9780439023528', 3),
('9780439139595', 8),
('9781526604736', 7),
('9780132350884', 2),
('9781492078005', 9),
('9781501124020', 7),
('9781118531648', 9);

-- ➕ Inventory for new books
INSERT INTO inventory (isbn, quantity_on_hand, quantity_on_order, reorder_level)
VALUES
('9780439023528', 10, 3, 3),
('9780439139595', 6, 2, 2),
('9781526604736', 12, 4, 4),
('9780132350884', 9, 5, 2),
('9781492078005', 11, 2, 3),
('9781501124020', 7, 2, 2),
('9781118531648', 8, 3, 2);

-- ➕ New Customers
INSERT INTO customers (user_id, name, phone, address, reading_preferences, profession)
VALUES
(5, 'Lucy Mwangi', '+254701223344', 'Nakuru, Kenya', 'Fiction, Romance', 'Writer'),
(6, 'Dennis Maina', '+254703998877', 'Kisumu, Kenya', 'Fantasy, Programming', 'Student'),
(7, 'Grace Achieng', '+254704112233', 'Eldoret, Kenya', 'Culture, Literature', 'Teacher'),
(8, 'Kevin Kamau', '+254709876543', 'Nairobi, Kenya', 'Software, Engineering', 'IT Technician'),
(9, 'Steve Otieno', '+254700778899', 'Kakamega, Kenya', 'Business, Research', 'Consultant'),
(10, 'Rita Wairimu', '+254722334455', 'Thika, Kenya', 'Fiction, Culture', 'Journalist');

-- ➕ More Orders
INSERT INTO orders (customer_id, status, payment_method, shipping_address, is_partial_allowed)
VALUES
(3, 'paid', 'M-Pesa', 'Nakuru, Kenya', FALSE),
(4, 'paid', 'Card', 'Kisumu, Kenya', TRUE),
(5, 'pending', 'Bank Transfer', 'Eldoret, Kenya', FALSE),
(6, 'shipped', 'M-Pesa', 'Nairobi, Kenya', FALSE);

-- ➕ Order Items
INSERT INTO order_items (order_id, isbn, quantity, unit_price)
VALUES
(3, '9780439023528', 1, 2500.00),
(3, '9781526604736', 1, 2200.00),
(4, '9780132350884', 1, 4500.00),
(4, '9781492078005', 1, 3800.00),
(5, '9781118531648', 2, 3600.00),
(6, '9781501124020', 1, 2100.00);

-- ➕ Payments
INSERT INTO payments (order_id, amount, payment_type, transaction_reference)
VALUES
(3, 4700.00, 'M-Pesa', 'MP789654123'),
(4, 8300.00, 'Card', 'CC998877665'),
(5, 7200.00, 'Bank', 'BT556677889'),
(6, 2100.00, 'M-Pesa', 'MP123123123');

-- ➕ Reviews
INSERT INTO reviews (customer_id, isbn, rating, comment)
VALUES
(3, '9780439023528', 5, 'Loved every chapter!'),
(4, '9780132350884', 4, 'Great for professional developers.'),
(5, '9781118531648', 5, 'Extremely useful for analysis students.'),
(6, '9781501124020', 4, 'Beautiful insights on African culture.'),
(7, '9781526604736', 5, 'Masterpiece!');

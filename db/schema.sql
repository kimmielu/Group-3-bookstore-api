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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

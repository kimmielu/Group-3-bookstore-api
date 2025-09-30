-- USERS table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('employee', 'customer', 'admin') NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CUSTOMERS table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    phone VARCHAR(30),
    address TEXT,
    reading_preferences VARCHAR(255),
    profession VARCHAR(100),
    CONSTRAINT fk_customer_user FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- PUBLISHERS table
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    address TEXT,
    contact_phone VARCHAR(30)
);

-- AUTHORS table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    bio TEXT
);

-- BOOKS table
CREATE TABLE books (
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
);

-- BOOK_AUTHORS table (many-to-many between books and authors)
CREATE TABLE book_authors (
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
);

-- INVENTORY table
CREATE TABLE inventory (
    isbn VARCHAR(13) PRIMARY KEY,
    quantity_on_hand INT NOT NULL DEFAULT 0,
    quantity_on_order INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 5,
    CONSTRAINT fk_inventory_book FOREIGN KEY (isbn)
        REFERENCES books(isbn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

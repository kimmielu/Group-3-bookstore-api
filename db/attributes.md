# Bookstore Tables and Attributes

## users
- user_id — INT, PK, auto-increment
- email — VARCHAR(255), unique, not null
- password_hash — VARCHAR(255), not null
- role — ENUM('employee','customer','admin')
- created_at — TIMESTAMP

## customers
- customer_id — INT, PK, auto-increment
- user_id — INT, FK → users.user_id
- name — VARCHAR(200)
- phone — VARCHAR(30)
- address — TEXT
- reading_preferences — VARCHAR(255)
- profession — VARCHAR(100)

## publishers
- publisher_id — INT, PK, auto-increment
- name — VARCHAR(200)
- address — TEXT
- contact_phone — VARCHAR(30)

## authors
- author_id — INT, PK, auto-increment
- name — VARCHAR(200)
- bio — TEXT

## books
- isbn — VARCHAR(13), PK
- title — VARCHAR(500)
- publisher_id — INT, FK → publishers.publisher_id
- price — DECIMAL(10,2)
- subject_area — VARCHAR(200)
- year_published — YEAR
- pages — INT
- language — VARCHAR(50)

## book_authors
- book_isbn — VARCHAR(13), FK → books.isbn
- author_id — INT, FK → authors.author_id
- PK = (book_isbn, author_id)

## inventory
- isbn — VARCHAR(13), PK, FK → books.isbn
- quantity_on_hand — INT
- quantity_on_order — INT
- reorder_level — INT

## orders
- order_id — INT, PK, auto-increment
- customer_id — INT, FK → customers.customer_id
- order_date — DATETIME
- status — ENUM('pending','paid','shipped','partial','cancelled')
- payment_method — VARCHAR(50)
- shipping_address — TEXT
- is_partial_allowed — BOOLEAN

## order_items
- order_item_id — INT, PK, auto-increment
- order_id — INT, FK → orders.order_id
- isbn — VARCHAR(13), FK → books.isbn
- quantity — INT
- unit_price — DECIMAL(10,2)

## payments
- payment_id — INT, PK, auto-increment
- order_id — INT, FK → orders.order_id
- amount — DECIMAL(10,2)
- payment_type — VARCHAR(50)
- transaction_reference — VARCHAR(255)
- payment_date — DATETIME

## reviews
- review_id — INT, PK, auto-increment
- customer_id — INT, FK → customers.customer_id
- isbn — VARCHAR(13), FK → books.isbn
- rating — TINYINT
- comment — TEXT
- review_date — DATETIME

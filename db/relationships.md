# Bookstore Relationships & Cardinalities

- **users → customers**
  - One user can have one customer profile (1—1 or 1—0..1).
  - Relationship: users.user_id → customers.user_id

- **publishers → books**
  - One publisher publishes many books (1—*).
  - Relationship: publishers.publisher_id → books.publisher_id

- **authors ↔ books**
  - Many authors can write many books (M—N).
  - Implemented via book_authors.
  - Relationships:
    - book_authors.book_isbn → books.isbn
    - book_authors.author_id → authors.author_id

- **books → inventory**
  - Each book has exactly one inventory record (1—1).
  - Relationship: inventory.isbn → books.isbn

- **customers → orders**
  - One customer can place many orders (1—*).
  - Relationship: customers.customer_id → orders.customer_id

- **orders → order_items**
  - One order has many order items (1—*).
  - Relationship: orders.order_id → order_items.order_id

- **books → order_items**
  - One book can appear in many order items (1—*).
  - Relationship: books.isbn → order_items.isbn

- **orders → payments**
  - One order can have one or more payments (1—*).
  - Relationship: orders.order_id → payments.order_id

- **customers → reviews**
  - One customer can write many reviews (1—*).
  - Relationship: customers.customer_id → reviews.customer_id

- **books → reviews**
  - One book can have many reviews (1—*).
  - Relationship: books.isbn → reviews.isbn

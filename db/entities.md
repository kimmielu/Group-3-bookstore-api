# Bookstore Entities (Canonical List)

- **users**
  - Purpose: authentication & roles (employee, customer, admin)

- **customers**
  - Purpose: customer profile linked to users (optional merge possible)

- **publishers**
  - Purpose: book suppliers

- **authors**
  - Purpose: book authors

- **books**
  - Purpose: book metadata (ISBN primary key)

- **book_authors**
  - Purpose: many-to-many join between books and authors

- **inventory**
  - Purpose: stock levels (quantity_on_hand, on_order, reorder_level)

- **orders**
  - Purpose: order header (customer, date, status, shipping)

- **order_items**
  - Purpose: line items for orders (book ISBN, quantity, unit_price)

- **payments**
  - Purpose: transaction records for orders

- **reviews**
  - Purpose: customer reviews/ratings for books

---

**Notes:**  
- *Customer History* (from the project spec) will be derived from `orders` + `order_items`.  
- For MVP, we could merge `users` + `customers` into one table, but keeping them separate is clearer.  

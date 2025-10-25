<?php
class Book {
    private $conn;
    private $table_name = "books";

    public $isbn;
    public $title;
    public $publisher_id;
    public $price;
    public $subject_area;
    public $pages;
    public $language;
    public $year_published;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Create Book
    public function create() {
        $query = "INSERT INTO " . $this->table_name . " (isbn, title, publisher_id, price, subject_area, pages, language)
                  VALUES (:isbn, :title, :publisher_id, :price, :subject_area, :pages, :language)";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':isbn', $this->isbn);
        $stmt->bindParam(':title', $this->title);
        $stmt->bindParam(':publisher_id', $this->publisher_id);
        $stmt->bindParam(':price', $this->price);
        $stmt->bindParam(':subject_area', $this->subject_area);
        $stmt->bindParam(':pages', $this->pages);
        $stmt->bindParam(':language', $this->language);

        if ($stmt->execute()) {
            return true;
        } else {
            print_r($stmt->errorInfo());
    return false;
        }
    }
    // Read Books
    public function readAll() {
        $query = "SELECT * FROM " . $this->table_name . " ORDER BY isbn DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }
}
?>